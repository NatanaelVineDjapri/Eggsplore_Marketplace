<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Shop;
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
            return response()->json(['message' => 'Error Validation'], 422);
        }

        $user = User::create([
            'name' => $request->firstname . ' ' . $request->lastname,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'role' => 'user',
            'image' => url('images/products/eggsplore1.jpg'),
        ]);

        $shop = Shop::create([
            'user_id' => $user->id,
            'name' => $user->name . "'s Shop",
            'description' => 'Owned by ' . $user->name,
        ]);

        $token = $user->createToken('Token for user ' . $user->email)->plainTextToken;

        return response()->json([
            'message' => 'Registration Success, Please Continue to Login!',
            'user' => $user,
            'shop' => $shop,
            'token' => $token,
        ], 201);
    }

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
            return response()->json(['message' => 'Wrong Email or Password'], 401);
        }

        $token = $user->createToken('Token for user ' . $user->email)->plainTextToken;

        return response()->json([
            'message' => 'Login Success',
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
            return response()->json(['message' => 'User not found'], 404);
        }

        return response()->json([
            'message' => 'User found',
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
            'confirmpassword.same' => 'Wrong password.',
        ]);

        if ($validator->fails()) {
            return response()->json(['message' => $validator->errors()->first()], 422);
        }

        $user = User::where('email', $request->email)->first();

        if (!$user) {
            return response()->json(['message' => 'User not found'], 404);
        }

        $user->password = Hash::make($request->newpassword);
        $user->save();

        return response()->json(['message' => 'Password changed successfully'],200);
    }

    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'message' => 'Logout successfull'
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

        $request->validate([
            'name'         => 'required|string|max:255',
            'email'        => 'required|email|unique:users,email,' . $user->id,
            'phone_number' => 'nullable|string|max:20',
            'address'      => 'nullable|string',
            'image'        => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);

        if ($request->has('name')) {
            $user->name = $request->name;
        }

        if ($request->has('email')) {
            $user->email = $request->email;
        }

        if ($request->has('phone_number')) {
            $user->phone_number = $request->phone_number;
        }

        if ($request->has('address')) {
            $user->address = $request->address;
        }

        if ($request->hasFile('image')) {
            $file = $request->file('image');
            $filename = 'user_' . $user->id . '_' . time() . '.' . $file->getClientOriginalExtension();
            $file->move(public_path('images/users'), $filename);
            $user->image = url('images/users/' . $filename);
        }

        $user->save();

        return response()->json([
            'message' => 'Profile changed succesfully',
            'user'    => $user->refresh(),
        ], 200);
    }

    public function updateBalance(Request $request, User $user)
    {
        $request->validate([
            'balance' => 'required|numeric|min:0'
        ]);

        $user->balance = $request->balance;
        $user->save();

        return response()->json([
            'message' => 'Balance berhasil diupdate',
            'balance' => $user->balance
        ]);
    }
}
