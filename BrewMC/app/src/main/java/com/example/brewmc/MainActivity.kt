package com.example.brewmc

import android.content.Context
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.LinearLayout
import androidx.core.content.ContextCompat
import androidx.core.view.children
import com.example.brewmc.R.*
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {

    // === image id tracking arrays ====
    // https://kotlinlang.org/docs/reference/basic-types.html#arrays
    var ids_tier1 = IntArray(12)
    var ids_tier2a = IntArray(12)
    var ids_tier2b = IntArray(2)
    var ids_tier2c = IntArray(2)
    var ids_tier3a = IntArray(4)
    var ids_tier3b = IntArray(3)
    var ids_tier3c = IntArray(3)
    var ids_tier3d = IntArray(2)
    var ids_tier3e = IntArray(3)
    var ids_tier4a = IntArray(2)
    var ids_tier4b = IntArray(2)
    var ids_tier4c = IntArray(2)
    var ids_tier4d = IntArray(2)
    var ids_tier4e = IntArray(2)
    var ids_tier4f = IntArray(2)
    var ids_tier4g = IntArray(3)
    var ids_tier4h = IntArray(2)
    var ids_tier5a = IntArray(2)
    var ids_tier5b = IntArray(2)

    var selectedTier1 = 0
    var selectedTier2: Int? = null
    var selectedTier3: Int? = null
    var selectedTier4: Int? = null
    var selectedTier5: Int? = null

    var currentPotion = 0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(layout.activity_main)
    }

    fun updateSelection (v: View) {
        val mView:ImageView = v as ImageView

        // === Update background colors within group ===
        // https://developer.android.com/reference/android/view/ViewParent
        // https://stackoverflow.com/a/4810375
        // https://stackoverflow.com/a/43687165
        val pView = mView.parent as LinearLayout
        for (cView in pView.children) {
            cView.setBackgroundColor(ContextCompat.getColor(this, color.blaze_orange))
//            Log.d("ArgumentSiblings", cView.id.toString())
        }
        mView.setBackgroundColor(ContextCompat.getColor(this, color.blaze_yellow))

//        https://developer.android.com/reference/android/view/ViewGroup
        val mViewPos = pView.indexOfChild(mView)
        selectedTier1 = mViewPos

        // debug notes
        Log.d("ArgumentID", mView.id.toString())
        Log.d("ArgumentParentID", pView.id.toString())
        Log.d("Argument SRC", mView.drawable.toString())
//        Log.d("ArgumentFamily", pView.children.toString())

        // update current tier selection
//        when (mView.id.toString()) {
//            in ids_tier1 -> {
//                selectedTier1 = mView.id
//                selectedTier2 = null
//                selectedTier3 = null
//                selectedTier4 = null
//                selectedTier5 = null
//            }
//            in ids_tier2a, ids_tier2b, ids_tier2c -> {
//                selectedTier2 = mView.id
//                selectedTier3 = null
//                selectedTier4 = null
//                selectedTier5 = null
//            }
//            in ids_tier3a, ids_tier3b, ids_tier3c, ids_tier3d, ids_tier3e -> {
//                selectedTier3 = mView.id
//                selectedTier4 = null
//                selectedTier5 = null
//            }
//            in ids_tier4a, ids_tier4b, ids_tier4c, ids_tier4d, ids_tier4e, ids_tier4f, ids_tier4g, ids_tier4h -> {
//                selectedTier4 = mView.id
//                selectedTier5 = null
//            }
//            in ids_tier5a, ids_tier5b -> {
//                selectedTier5 = mView.id
//            }
//        }

        // load next tier


        // load potion state

    } // end of function updateSelection

    fun unlockNextTier(key:Int) {
        //
    }

    private fun reloadUIState() {
        for (c in tier1.children) {
            c.setBackgroundColor(ContextCompat.getColor(this, color.blaze_orange))
        }
        tier1.getChildAt(selectedTier1).setBackgroundColor(ContextCompat.getColor(this, color.blaze_yellow))


        potion_display.setImageResource(R.string..corresponding_potion_drawables[currentPotion])
    }

    override fun onSaveInstanceState(outState: Bundle) {
        outState.putInt("tier1selected", selectedTier1)
        selectedTier2?.let { outState.putInt("tier2selected", it) }
        selectedTier3?.let { outState.putInt("tier3selected", it) }
        selectedTier4?.let { outState.putInt("tier4selected", it) }
        selectedTier5?.let { outState.putInt("tier5selected", it) }

        outState.putInt("cPotion", currentPotion)

        super.onSaveInstanceState(outState)
    }

    override fun onRestoreInstanceState(savedInstanceState: Bundle) {
        super.onRestoreInstanceState(savedInstanceState)

        selectedTier1 = savedInstanceState.getInt("tier1selected", 0)
        selectedTier2 = savedInstanceState.getInt("tier2selected", 0)
        selectedTier3 = savedInstanceState.getInt("tier3selected", 0)
        selectedTier4 = savedInstanceState.getInt("tier4selected", 0)
        selectedTier5 = savedInstanceState.getInt("tier5selected", 0)

        currentPotion = savedInstanceState.getInt("cPotion", 0)

        reloadUIState()
    }
}

// Snap horizontal scroll view (for future use)
// https://www.velir.com/blog/2010/11/17/android-creating-snapping-horizontal-scroll-view

/* ======== drawable assets -- ingredients ========
 * blpo     blaze powder
 * fespey   fermented spider eye
 * ghte     ghast tear
 * gldu     glowstone dust
 * glmesl   glistering melon slice
 * goca     golden carrot
 * gu       gunpowder
 * macr     magma cream
 * newa     nether wart
 * phme     phantom membrane
 * pu       pufferfish
 * rafo     rabbit foot
 * re       redstone dust
 * spey     spider eye
 * su       sugar
 * tuhe     turtle helmet
 */