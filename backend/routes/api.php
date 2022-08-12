<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\OrderController;
use App\Http\Controllers\ProductController;
use App\Models\Order;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/get/orders/{userId}/{limit}', [OrderController::class, 'getOrdes']);
    Route::get('/get/products/{orderId}', [OrderController::class, 'getProducts']);
    Route::post('/set/orderandproduct', [OrderController::class, 'setOrderAndProducts']);
    Route::get('/get/allusers', [AuthController::class, 'getAllUsers']);
    Route::get('/get/productById/{orderId}', [ProductController::class, 'getProductByOrderId']);
    Route::get('/get/user/{userId}', [AuthController::class, 'getUser']);
    Route::put('/update/user/{userId}', [AuthController::class, 'updateUser']);
});

Route::post('/create/user', [AuthController::class, 'register']);
Route::post('/login/user', [AuthController::class, 'login']);
Route::post('/check/token', [AuthController::class, 'checkToken']);
Route::get("/get/image/{id}", [AuthController::class, 'getImageById']);
Route::get("/get/imageUsers/{imagePath}", [AuthController::class, 'getImage']);
Route::get('/get/alluser/companyroom/{userId}/{maxLength}', [AuthController::class, 'companyRoomAllUsers']);
