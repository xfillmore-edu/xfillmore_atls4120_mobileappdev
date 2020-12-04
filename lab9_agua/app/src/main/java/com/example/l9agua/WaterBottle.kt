package com.example.l9agua

data class WaterBottle(var qty:Int=0) {
    fun updateWaterLog(amount:Int, format:Boolean) {
        var amt:Int = 0
        if (format) { // submitted in oz
            amt = convertToMetric(amount)
        }
        else {
            amt = amount
        }
        qty += amt
    }

    private fun convertToMetric(amt:Int): Int {
        var metricamt:Double = amt * 29.5735
        return metricamt.toInt()
    }

}
