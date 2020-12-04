package com.example.brewmc

import android.content.Context
import android.graphics.drawable.Drawable
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
import java.lang.reflect.Field

class MainActivity : AppCompatActivity() {

    // === image id tracking arrays ====
    // https://kotlinlang.org/docs/reference/basic-types.html#arrays
    private var ids_tier1 : Array<String> =  Array(12) {i -> ("imageView" + (i+ 2).toString())}
    private var ids_tier2a : Array<String> = Array(12) { i -> ("imageView" + (i+18).toString())}
    private var ids_tier2b : Array<String> = Array( 2) { i -> ("imageView" + (i+30).toString())}
    private var ids_tier2c : Array<String> = Array( 2) { i -> ("imageView" + (i+32).toString())}
    private var ids_tier3a : Array<String> = Array( 4) { i -> ("imageView" + (i+34).toString())}
    private var ids_tier3b : Array<String> = Array( 3) { i -> ("imageView" + (i+39).toString())}
    private var ids_tier3c : Array<String> = Array( 3) { i -> ("imageView" + (i+42).toString())}
    private var ids_tier3d : Array<String> = Array( 2) { i -> ("imageView" + (i+45).toString())}
    private var ids_tier3e : Array<String> = Array( 3) { i -> ("imageView" + (i+47).toString())}
    private var ids_tier4a : Array<String> = Array( 2) { i -> ("imageView" + (i+50).toString())}
    private var ids_tier4b : Array<String> = Array( 2) { i -> ("imageView" + (i+52).toString())}
    private var ids_tier4c : Array<String> = Array( 2) { i -> ("imageView" + (i+54).toString())}
    private var ids_tier4d : Array<String> = Array( 2) { i -> ("imageView" + (i+56).toString())}
    private var ids_tier4e : Array<String> = Array( 2) { i -> ("imageView" + (i+58).toString())}
    private var ids_tier4f : Array<String> = Array( 2) { i -> ("imageView" + (i+61).toString())}
    private var ids_tier4g : Array<String> = Array( 3) { i -> ("imageView" + (i+63).toString())}
    private var ids_tier4h : Array<String> = Array( 2) { i -> ("imageView" + (i+66).toString())}
    private var ids_tier5a : Array<String> = Array( 2) { i -> ("imageView" + (i+68).toString())}
    private var ids_tier5b : Array<String> = Array( 2) { i -> ("imageView" + (i+70).toString())}

    var selectedTier1 = 0
    var selectedTier2: Int? = null
    var selectedTier3: Int? = null
    var selectedTier4: Int? = null
    var selectedTier5: Int? = null

    var currentPotion = 0
    lateinit var potionimgs:Array<String>

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(layout.activity_main)

        potionimgs = resources.getStringArray(array.corresponding_potion_drawables)
        potion_name.text = resources.getStringArray(array.potions)[currentPotion]
        potion_effect.text = resources.getStringArray(array.effects)[currentPotion]
    }

    fun updateSelection (v: View) {
        val mView:ImageView = v as ImageView

        // comments of https://stackoverflow.com/a/14648102
//        mView.resources.getResourceName(mView.id)
//        mView.resources.getResourceEntryName(mView.id)

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
        val nullIngredientIDs : Array<String> = Array(19) {
            "imageView2"; "imageView18"; "imageView30"; "imageView32"
            "imageView35"; "imageView39"; "imageView42"; "imageView45"
            "imageView47"; "imageView50"; "imageView52"; "imageView54"
            "imageView56"; "imageView58"; "imageView61"; "imageView63"
            "imageView66"; "imageView68"; "imageView70"
        }
        if (mView.id.toString() in nullIngredientIDs) {
            when (mView.id.toString()) {
                in ids_tier1 -> {
                    selectedTier1 = mView.id
                    selectedTier2 = null
                }
                in ids_tier2a, in ids_tier2b, in ids_tier2c -> {
                    selectedTier2 = mView.id
                    selectedTier3 = null
                }
                in ids_tier3a, in ids_tier3b, in ids_tier3c, in ids_tier3d, in ids_tier3e -> {
                    selectedTier3 = mView.id
                    selectedTier4 = null
                }
                in ids_tier4a, in ids_tier4b, in ids_tier4c, in ids_tier4d,
                in ids_tier4e, in ids_tier4f, in ids_tier4g, in ids_tier4h -> {
                    selectedTier4 = mView.id
                    selectedTier5 = null
                }
                in ids_tier5a, in ids_tier5b -> {
                    selectedTier5 = mView.id
                }
            }
        }
        else {
            when (mView.id.toString()) {
                in ids_tier1 -> {
                    selectedTier1 = mView.id
                    selectedTier2 = 0
                    selectedTier3 = null
                }
                in ids_tier2a, in ids_tier2b, in ids_tier2c -> {
                    selectedTier2 = mView.id
                    selectedTier3 = 0
                    selectedTier4 = null
                }
                in ids_tier3a, in ids_tier3b, in ids_tier3c, in ids_tier3d, in ids_tier3e -> {
                    selectedTier3 = mView.id
                    selectedTier4 = 0
                    selectedTier5 = null
                }
                in ids_tier4a, in ids_tier4b, in ids_tier4c, in ids_tier4d,
                in ids_tier4e, in ids_tier4f, in ids_tier4g, in ids_tier4h -> {
                    selectedTier4 = mView.id
                    selectedTier5 = 0
                }
                in ids_tier5a, in ids_tier5b -> {
                    selectedTier5 = mView.id
                }
            }
        }

        // load next tier
        unlockNextTier(mView.id.toString())

        // LOAD POTION STATE
        getCurrentBrew()

    } // end of function updateSelection

    fun unlockNextTier(key:String) {
        when (key) {
            // check each subtier grouping of imageView IDs for which tier to display
            // set attribute <visibility> to <visible>
            // reset background colors to default (no ingredient == @color/blaze_yellow)
            // barrier constraints will place where expected
        }
    }

    fun getCurrentBrew() {
        // trace ingredient path to determine which potion is currently accurate
        // detect which ingredients are selected by checking background color for @color/blaze_yellow
        // then update drawable src for <potion_display> and text for <potion_name>, <potion_effect>
        // based on aligned string-arrays
    }

    private fun reloadUIState() {
        for (c in tier1.children) {
            c.setBackgroundColor(ContextCompat.getColor(this, color.blaze_orange))
        }
        tier1.getChildAt(selectedTier1).setBackgroundColor(ContextCompat.getColor(this, color.blaze_yellow))
        if (selectedTier2 != null) {
            // check which subtier (a, b, c) and update
        }
        if (selectedTier3 != null) {
            // check which subtier (a, b, c, d, e) and update
        }
        if (selectedTier4 != null) {
            // check which subtier (a, b, c, d, e, f, g, h) and update
        }
        if (selectedTier5 != null) {
            // check which subtier (a, b) and update
        }


        // LOAD BREW INFORMATION
        getCurrentBrew() // excludes state var for currentPotion...
        // https://stackoverflow.com/a/21856396
        // https://teamtreehouse.com/community/getdrawableint-id-is-deprecated-in-api-22
//        potion_display.setImageDrawable() = resources.getDrawable(resources.getIdentifier((potionimgs[currentPotion], "id", packageName)))
//        val field:Field = drawable.getDeclaredField(potionimgs[currentPotion])
//        val srcid :Int= field.getInt(null)
//        val drawable: Drawable? = ContextCompat.getDrawable(this, srcid)
        // CAUSES APP CRASH ON NEW INSTANCE (ROTATION)
//        val srcid = applicationContext.resources.getIdentifier(potionimgs[currentPotion], "string", packageName)
//        Log.d("Reload SRCID", srcid.toString())
//        val drawable: Drawable? = ContextCompat.getDrawable(this, srcid)
//        potion_display.setImageDrawable((drawable))


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