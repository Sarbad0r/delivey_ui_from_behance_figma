<?php

namespace App\Http\Controllers;

use App\Models\Order;
use App\Models\Product;
use Illuminate\Http\Request;

class OrderController extends Controller
{
    public function getOrdes($userId)
    {
        return response([
            "orders" => Order::where('user_id', $userId)->get(),
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
        if (!empty($request['productList'])) {
            $getOrderId = Order::insertGetId([
                'user_id' => $request['user_id'],
                'qty_of_products' => $request['qty_of_products'],
                'total' => $request['total']
            ]);

            $products = $request->productList->all();
            foreach ($products as $each) {
                Product::create([
                    'order_id' => $getOrderId,
                    'name' => $each['name'],
                    'price' => $each['price'],
                    'quantity' => $each['quantity'],
                    'about' => $each['about'],
                    'ingredients' => $each['ingredients']
                ]);
            }
        } else {
            Order::create([
                'user_id' => $request['user_id'],
                'qty_of_products' => $request['qty_of_products'],
                'total' => $request['total']
            ]);
        }
    }
}