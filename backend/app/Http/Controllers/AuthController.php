<?php

namespace App\Http\Controllers;

use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        if (!empty($request['imagejun'])) {
            $path = $request->file('imagejun')->store('images');
            $check = User::where('email', $request['email'])->first();
            if (!$check) {
                $user = User::create([
                    'name' => $request['name'],
                    "email" => $request['email'],
                    "password" => Hash::make($request['password']),
                    "image" => $path,
                    'phone_number' => $request['phone_number']
                ]);

                return response([
                    'success' => true,
                    'user' => $user,
                    'token' => $user->createToken('secret')->plainTextToken
                ]);
            } else {
                return response([
                    'success' => false,
                    'message' => "Такой пользователь уже существует"
                ]);
            }
        } else {
            $check = User::where('email', $request['email'])->first();
            if (!$check) {
                $user = User::create([
                    'name' => $request['name'],
                    "email" => $request['email'],
                    "password" => Hash::make($request['password']),
                    'phone_number' => $request['phone_number'],
                ]);

                return response([
                    'success' => true,
                    'user' => $user,
                    'token' => $user->createToken('secret')->plainTextToken
                ]);
            } else {
                return response([
                    'success' => false,
                    'message' => "Такой пользователь уже существует"
                ]);
            }
        }
    }

    public function login(Request $request)
    {
        $user = User::where('email', $request['email'])->first();
        if (!$user) {
            return response([
                'success' => false,
                'message' => 'Такой пользователь не существует'
            ]);
        } else if (!Hash::check($request['password'], $user->password)) {
            return response([
                'success' => false,
                'message' => 'Ошибка пароля'
            ]);
        } else {
            return response([
                'success' => true,
                'user' => $user,
                'token' => $user->createToken('secret')->plainTextToken
            ]);
        }
    }

    public function checkToken(Request $request)
    {
        $timeForToken = Carbon::now()->subMonth(1);
        if (empty($request['token'])) {
            return response([
                'success' => false,
                'message' => 'no tokens'
            ]);
        }
        if (strpos($request['token'], '|') === false) {
            $check = DB::table('personal_access_tokens')->where('token', hash('sha256', $request['token']))->where('created_at', '>=', $timeForToken)->first();

            if (!$check) {
                return response([
                    'success' => false,
                    'message' => 'no tokens'
                ]);
            } else {
                return response([
                    'token' => $check,
                    'success' => true,
                    'message' => 'done',
                ]);
            }
        }
        [$idToken, $token] = explode('|', $request['token'], 2);

        $check = DB::table('personal_access_tokens')->where('token', hash('sha256', $token))->where('created_at', '>=', $timeForToken)->first();

        if (!$check) {
            return [
                'success' => false,
                'message' => 'no tokens'
            ];
        }
        return [
            // 'token' => DB::table('personal_access_tokens')->get(),
            'token' =>  $check,
            'success' => true,
            'message' => 'done',
            'length of token' => $token,
        ];
    }

    public function getImage($id)
    {
        $getPath = User::where('id', $id)->first()->value('image');
        return response()->file(storage_path('app/' . $getPath));
    }

    public function getAllUsers()
    {
        return response([
            'users' => User::select('name', 'image')->get()
        ]);
    }
    public function getUser($userId)
    {
        $user = User::where('id', $userId)->first();
        if ($user) {
            return response([
                'success' => true,
                'user' => $user
            ]);
        } else {
            return response([
                'success' => false
            ]);
        }
    }
    public function updateUser(Request $request, $userId)
    {
        $user = User::where('id', $userId)->first();
        if ($user) {
            User::where('id', $userId)->update([
                "name" => $request['name'],
                "email" => $request['email'],
                "password" => Hash::make($request['password']),
                "phone_number" => $request['phone_number']
            ]);
            return response([
                'success' => true,
                'user' => User::where('id', $userId)->first()
            ]);
        } else {
            return response([
                'success' => false
            ]);
        }
    }

    public function logout(Request $request)
    {
        if (strpos($request['token'], '|') === false) {
            DB::table('personal_access_tokens')->where("token", hash('sha256', $request['token']))->delete();
            return response([
                "success" => true,
            ]);
        } else {
            [$idToken, $token] = explode('|', $request['token'], 2);
            DB::table('personal_access_tokens')->where('token', hash('sha256', $token))->delete();
            return response([
                "success" => true,
            ]);
        }
    }
}
