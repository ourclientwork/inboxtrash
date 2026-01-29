<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('coupons', function (Blueprint $table) {
            $table->id(); // unsignedBigInteger primary key
            $table->string('code')->unique();
            $table->string('name');
            $table->integer('usage')->default(0);
            $table->integer('limit')->default(-1)->comment('Maximum usage limit. -1 means unlimited.');
            $table->boolean('type')->default(0)->comment('1: Percentage, 0: Fixed Price');
            $table->decimal('value', 10, 2)->nullable();
            $table->boolean('is_active')->default(true)->index();
            $table->timestamp('expired_at')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('coupons');
    }
};
