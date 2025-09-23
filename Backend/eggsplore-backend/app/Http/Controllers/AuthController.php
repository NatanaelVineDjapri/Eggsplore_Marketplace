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
            'password'  => 'required|string|min:6|confirmed', 
        ]);

        if ($validator->fails()) {
            return response()->json(['message' => 'Validasi Gagal'], 422);
        }

        $user = User::create([
            'name' => $request->firstname . ' ' . $request->lastname,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'role' => 'user',
        ]);

        $token = Str::random(60);

        return response()->json([
            'message' => 'Register Berhasil',
            'user' => $user,
            'token' => $token
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

        $token = Str::random(60);

        return response()->json([
            'message' => 'Login berhasil',
            'user' => $user,
            'token' => $token
        ]);
    }

    public function verifyUser(Request $request) {
        $validator = Validator::make($request->all(), [
            'firstname' => 'required|string|max:255',
            'lastname' => 'required|string|max:255',
            'email' => 'required|email',
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
                'fullname' => $fullname,
                'email' => $request->email,
            ]
        ], 200);
    }

    public function changePassword(Request $request){
        $validator= Validator::make($request->all(),[
            'fullname' => 'required|string|max:255',
            'email' => 'required|email',
            'newpassword' => 'required',
            'confirmpassword' => 'required|same:newpassword',
        ],[
            'confirmpassword.same' => 'Konfirmasi password tidak sesuai.',

        ]);

        if ($validator->fails()) {
            return response()->json(['message' => $validator->errors()->first()], 422);
        }
   
        $user = User::where('name', $request->fullname)
                ->where('email', $request->email)
                ->first();
                
         if (!$user) {
            return response()->json(['message' => 'User tidak ditemukan'], 404);
        }

        $user->password = Hash::make($request -> newpassword);
        $user->save();

        return response()->json(['message' => 'Password berhasil diubah'],200);
    }


   
}