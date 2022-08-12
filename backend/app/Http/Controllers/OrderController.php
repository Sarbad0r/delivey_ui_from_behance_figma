<?php

namespace App\Http\Controllers;

use App\Models\Order;
use App\Models\Product;
use Illuminate\Http\Request;

class OrderController extends Controller
{
    public function getOrdes($userId, $limit)
    {
        return response([
            "orders" => Order::where('user_id', $userId)->paginate($limit)
        ]);
    }

    public function getProducts($orderId)
    {
        return response([
            "products" => Product::where('order_id', $orderId)->get(),
        ]);
    }

    public function setOrderAndProducts(Request $request)
    {
        $dateTime = date("Y-m-d H:i:s");
        if (!empty($request['productList'])) {
            $getOrderId = Order::insertGetId([
                'user_id' => $request['user_id'],
                'qty_of_products' => $request['qty_of_products'],
                'total' => $request['total'],
                'address' => $request['address'],
                'created_at' => $dateTime
            ]);

            $products = $request['productList'];
            foreach ($products as $each) {
                Product::create([
                    'order_id' => $getOrderId,
                    'name' => $each['name'],
                    'price' => $each['price'],
                    'image' => $each['image'],
                    'quantity' => $each['quantity'],
                    'about' => $each['about'],
                    'ingredients' => $each['ingredients']
                ]);
            }
            return response([
                'success' => true
            ]);
        } else {
            Order::create([
                'user_id' => $request['user_id'],
                'qty_of_products' => $request['qty_of_products'],
                'total' => $request['total'],
                'address' => $request['address']
            ]);
            return response([
                'success' => true
            ]);
        }
    }

    
}
