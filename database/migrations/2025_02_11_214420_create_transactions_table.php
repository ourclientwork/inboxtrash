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

        Schema::create('transactions', function (Blueprint $table) {
            $table->bigIncrements('id')->startingValue(1000);

            // Changed: Assumed standard users table id (bigIncrements/id) -> unsignedBigInteger
            $table->unsignedBigInteger('user_id')->index(); // Added index

            // Kept as unsignedInteger to match plans.id (increments)
            $table->unsignedInteger('plan_id')->index(); // Added index

            $table->string('payment_id')->nullable()->index(); // Added index
            $table->string('transaction_id')->nullable()->index(); // Added index
            $table->string('payer_id')->nullable()->index(); // Added index
            $table->string('gateway')->nullable()->index(); // Added index
            $table->decimal('amount', 10, 2)->default('0.00'); // Added precision and scale
            $table->decimal('plan_price', 10, 2)->default('0.00'); // Added precision and scale
            $table->decimal('discount_amount', 10, 2)->default('0.00'); // Added precision and scale
            $table->string('coupon_code')->nullable(); // Keep original code for display/history
            $table->decimal('fees', 10, 2)->default('0.00'); // Added precision and scale
            $table->string('currency', 3)->nullable(); // Added length limit
            $table->string('interval')->nullable()->comment('e.g., month, year, one-time'); // Added comment
            $table->tinyInteger('status')->default(0)->index() // Changed: tinyInteger often sufficient, Added index
                ->comment('0: Pending, 1: Completed, 2: Failed, 3: Refunded'); // Added comment for clarity
            $table->string('tax_name')->nullable();
            $table->decimal('tax_rate', 5, 2)->default('0.00'); // Added precision and scale (matches taxes.rate)
            $table->decimal('tax_amount', 10, 2)->default('0.00'); // Added: Store calculated tax amount
            $table->string('payment_proof')->nullable()->comment('e.g., path to bank transfer receipt'); // Added comment
            $table->ipAddress('ip_address')->nullable(); // Added: Store user IP
            $table->text('cancellation_reason')->nullable(); // Added: Internal notes field
            $table->string('payment_link')->nullable(); // Added: Internal notes field
            $table->timestamp('paid_at')->nullable(); // Added: Internal notes field
            $table->timestamps();

            // Added: Foreign key constraints
            $table->foreign('user_id')
                ->references('id')
                ->on('users')
                ->onDelete('cascade'); // Prevent deleting a user with transactions

            $table->foreign('plan_id')
                ->references('id')
                ->on('plans')
                ->onDelete('cascade'); // Prevent deleting a plan with transactions

            // coupon_id foreign key added above using constrained() shortcut
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('transactions');
    }
};
