<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    public function getProductByOrderId($orderId)
    {
        return response([
            'products' => Product::where('order_id', $orderId)->get()
        ]);
    }
}
