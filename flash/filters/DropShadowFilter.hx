package flash.filters;


import flash.geom.Point;
import flash.geom.Rectangle;
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;


class DropShadowFilter extends BitmapFilter {
	
	
	private static inline var DEGREES_FULL_RADIUS = 360.0;
	
	public var alpha:Float;
	public var angle:Float;
	public var blurX:Float;
	public var blurY:Float;
	public var color:Int;
	public var distance:Float;
	public var hideObject:Bool;
	public var inner:Bool;
	public var knockout:Bool;
	public var quality:Int;
	public var strength:Float;
	
	
	public function new (in_distance:Float = 4.0, in_angle:Float = 45.0, in_color:Int = 0, in_alpha:Float = 1.0, in_blurX:Float = 4.0, in_blurY:Float = 4.0, in_strength:Float = 1.0, in_quality:Int = 1, in_inner:Bool = false, in_knockout:Bool = false, in_hideObject:Bool = false) {
		
		super ("DropShadowFilter");
		
		distance = in_distance;
		angle = in_angle;
		color = in_color;
		alpha = in_alpha;
		blurX = in_blurX;
		blurY = in_blurX;
		strength = in_strength;
		quality = in_quality;
		inner = in_inner;
		knockout = in_knockout;
		hideObject = in_hideObject;
		___cached = false;
		
	}
	
	
	override public function clone ():BitmapFilter {
		
		return new DropShadowFilter (distance, angle, color, alpha, blurX, blurY, strength, quality, inner, knockout, hideObject);
		
	}
	
	
	override public function __applyFilter(surface:CanvasElement, rect:Rectangle = null, refreshCache:Bool = false):Void {
		
		if (!___cached || refreshCache) {
			
			var distanceX = distance * Math.sin (2 * Math.PI * angle / DEGREES_FULL_RADIUS);
			var distanceY = distance * Math.cos (2 * Math.PI * angle / DEGREES_FULL_RADIUS);
			var blurRadius = Math.max (blurX, blurY); //if (distanceY == 0) blurX;
			//else if (distanceX == 0) blurY;
			//else(blurX * (distanceX/distanceY)/ (distanceX+distanceY) + blurY * (distanceY/distanceX)/ (distanceX+distanceY))/2;
			
			var context:CanvasRenderingContext2D = surface.getContext ("2d");
			context.shadowOffsetX = distanceX;
	        context.shadowOffsetY = distanceY;
	        context.shadowBlur = blurRadius;
	        context.shadowColor = "rgba(" + ((color >> 16) & 0xFF) + "," + ((color >> 8) & 0xFF) + "," + (color & 0xFF) + "," + alpha + ")";
	        ___cached = true;
			
	    }
		
	}
	
	
}
