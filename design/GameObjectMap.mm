<map version="0.8.1">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED="1256084593421" ID="Freemind_Link_1776206529" MODIFIED="1256084601124" TEXT="object">
<node CREATED="1256084633519" ID="_" MODIFIED="1256085870494" POSITION="right" TEXT="Item" VSHIFT="-143">
<hook NAME="accessories/plugins/NodeNote.properties">
<text>physicalObject:PhysicalObject&#xa;</text>
</hook>
<node CREATED="1256084638322" ID="Freemind_Link_639655516" MODIFIED="1256085778664" TEXT="Food">
<node CREATED="1256084644937" ID="Freemind_Link_1816304101" MODIFIED="1256085782141" TEXT="Herb"/>
</node>
<node CREATED="1256084650390" ID="Freemind_Link_392501059" MODIFIED="1256085788597" TEXT="Equipment"/>
</node>
<node CREATED="1256084671408" HGAP="60" ID="Freemind_Link_1768575289" MODIFIED="1256085922785" POSITION="left" TEXT="TimedObject" VSHIFT="-8">
<hook NAME="accessories/plugins/NodeNote.properties">
<text>accumulates energy every world tick.&#xa;with enough energy, it can take a turn.&#xa;&#xa;energy:int;&#xa;energyPerTurn:int;&#xa;</text>
</hook>
<node CREATED="1256084679759" ID="Freemind_Link_1451777353" MODIFIED="1256085909976" TEXT="LivingObject" VSHIFT="-13">
<hook NAME="accessories/plugins/NodeNote.properties">
<text>physicalObject:PhysicalObject&#xa;&#xa;hitPoints:int&#xa;maxHitPoints:int&#xa;&#xa;age:int&#xa;averageLifespan:int&#xa;lifespanVariance:int&#xa;</text>
</hook>
<node CREATED="1256084812183" HGAP="24" ID="Freemind_Link_433376707" MODIFIED="1256085911830" TEXT="MovingObject" VSHIFT="-16">
<hook NAME="accessories/plugins/NodeNote.properties">
<text>contains movment vars</text>
</hook>
</node>
</node>
<node CREATED="1256084687072" HGAP="32" ID="Freemind_Link_1813732297" MODIFIED="1256085914294" TEXT="StatusEffect" VSHIFT="3">
<hook NAME="accessories/plugins/NodeNote.properties">
<text>gains energy every world turn.  when energy is full, it does it&apos;s thing.&#xa;&#xa;target:Object;&#xa;targetStat:int</text>
</hook>
</node>
</node>
<node CREATED="1256084866724" ID="Freemind_Link_258406531" MODIFIED="1256085800373" POSITION="right" TEXT="PhysicalObject" VSHIFT="54">
<hook NAME="accessories/plugins/NodeNote.properties">
<text>tx:int&#xa;ty:int&#xa;animates:Boolean;&#xa;animation:Animation;&#xa;icon:BitmapData&#xa;&#xa;</text>
</hook>
</node>
<node CREATED="1256085513723" HGAP="25" ID="Freemind_Link_1480326934" MODIFIED="1256085973327" POSITION="left" TEXT="Stat" VSHIFT="-24">
<hook NAME="accessories/plugins/NodeNote.properties">
<text>public static const HIT_POINTS:int = 0;&#xa;public static const MAGIC_POINTS:int = 1;&#xa;public static const ENERGY:int = 2;&#xa;public stai&#xa;&#xa;</text>
</hook>
</node>
</node>
</map>
