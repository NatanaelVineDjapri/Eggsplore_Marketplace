<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller
{
    public function allUsers()
    {
        $users = User::all();
        return response()->json($users);
    }
    public function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'firstname' => 'required|string|max:255',
            'lastname'  => 'required|string|max:255',
            'email'     => 'required|email|unique:users,email',
            'password'  => 'required|string|min:6|', 
        ]);

        if ($validator->fails()) {
            return response()->json(['message' => 'Validasi Gagal'], 422);
        }

        $user = User::create([
            'name' => $request->firstname . ' ' . $request->lastname,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'role' => 'user',
            'image' => url('images/products/eggsplore1.jpg'), 

        ]);

        return response()->json([
            'message' => 'Register Berhasil',
            'user' => $user,
        ], 201);
    }

    // Login user
    public function login(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'password' => 'required'
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $user = User::where('email', $request->email)->first();

        if (!$user || !Hash::check($request->password, $user->password)) {
            return response()->json(['message' => 'Email atau password salah'], 401);
        }

        $token = $user->createToken('Token for user ' . $user->email)->plainTextToken;

        return response()->json([
            'message' => 'Login berhasil',
            'user' => $user,
            'token' => $token
        ]);
    }

    public function verifyUser(Request $request) {
        $validator = Validator::make($request->all(), [
            'firstname' => 'required|string|max:255',
            'lastname'  => 'required|string|max:255',
            'email'     => 'required|email',
        ]);

        if ($validator->fails()) {
            return response()->json(['message' => $validator->errors()->first()], 422);
        }

        $fullname = $request->firstname . ' ' . $request->lastname;

        $user = User::where('name', $fullname)
                    ->where('email', $request->email)
                    ->first();

        if (!$user) {
            return response()->json(['message' => 'User tidak ditemukan'], 404);
        }

        return response()->json([
            'message' => 'User ditemukan',
            'data' => [
                'email' => $request->email,
            ]
        ], 200);
    }


    public function changePassword(Request $request){
        $validator = Validator::make($request->all(),[
            'email'           => 'required|email',
            'newpassword'     => 'required|min:6',
            'confirmpassword' => 'required|same:newpassword',
        ],[
            'confirmpassword.same' => 'Konfirmasi password tidak sesuai.',
        ]);

        if ($validator->fails()) {
            return response()->json(['message' => $validator->errors()->first()], 422);
        }

        $user = User::where('email', $request->email)->first();
                
        if (!$user) {
            return response()->json(['message' => 'User tidak ditemukan'], 404);
        }

        $user->password = Hash::make($request->newpassword);
        $user->save();

        return response()->json(['message' => 'Password berhasil diubah'],200);
    }

    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'message' => 'Berhasil logout'
        ]);
    }

    public function getAuthenticatedUser(Request $request)
    {
        if ($request->user()) {
            return response()->json($request->user(), 200);
        }
        return response()->json(['message' => 'Unauthenticated.'], 401);
    }

    public function updateProfile(Request $request)
    {
    $user = $request->user(); 

    $validator = Validator::make($request->all(), [
        'firstname' => 'sometimes|string|max:255',
        'lastname'  => 'sometimes|string|max:255',
        'email'     => 'sometimes|email|unique:users,email,' . $user->id,
        'image'     => 'sometimes|image|mimes:jpeg,png,jpg,gif|max:2048',
    ]);

    if ($validator->fails()) {
        return response()->json(['message' => $validator->errors()->first()], 422);
    }

    if ($request->has('firstname') || $request->has('lastname')) {
        $user->name = trim(($request->firstname ?? explode(' ', $user->name)[0]) . ' ' . ($request->lastname ?? explode(' ', $user->name)[1] ?? ''));
    }

    if ($request->has('email')) {
        $user->email = $request->email;
    }

    if ($request->hasFile('image')) {
        $file = $request->file('image');
        $filename = 'user_' . $user->id . '_' . time() . '.' . $file->getClientOriginalExtension();
        $file->move(public_path('images/users'), $filename);
        $user->image = url('images/users/' . $filename);
    }

    $user->save();

    return response()->json([
        'message' => 'Profile berhasil diperbarui',
        'user' => $user,
    ], 200);
}

    public function me(Request $request)
    {
        return response()->json($request->user());
    }

}