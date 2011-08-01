import mx.utils.Delegate;
import toolbarcomponent.core.*;
//
class toolbarcomponent.core.Scroller {
	private var classScope:Object;
	private var dir:String;
	private var clip:MovieClip;
	private var holderClip:MovieClip;
	private var maskClip:MovieClip;
	private var scrolling:Boolean;
	private var scrollMe:MovieClip;
	//
	private static var scrollSpeed = 6;
	//
	public function Scroller(classScope:Object, dir:String, scrollMe:MovieClip, holder:MovieClip, mask:MovieClip) {
		this.classScope = classScope;
		this.dir = dir;
		this.scrollMe = scrollMe;
		this.holderClip = holder;
		this.maskClip = mask;
		scrolling = false;
		//
		clip = createScrollerClip();
		//
		clip.onPress = Delegate.create(this, scrollTrue);
		clip.onRelease = Delegate.create(this, scrollFalse);
		clip.onEnterFrame = Delegate.create(this, scrollClip);
	}
	//
	private function scrollClip():Void {
		if (scrolling) {
			if (dir == "left" && isInBounds()) {
				scrollMe._x += scrollSpeed;
			}
			if (dir == "right" && isInBounds()) {
				scrollMe._x -= scrollSpeed;
			}
		}
	}
	//
	private function isInBounds():Boolean {
		if (dir == "left") {
			if (scrollMe._x < maskClip._x) {
				return true;
			}
		} else {
			if ((scrollMe._x+scrollMe._width)>(maskClip._x+maskClip._width)) {
				return true;
			}
		}
		return false;
	}
	//
	private function createScrollerClip():MovieClip {
		var depth:Number = holderClip.getNextHighestDepth();
		var scrollClip:MovieClip = holderClip.attachMovie("scrollMC", "scrollLeft", depth);
		if (dir == "left") {
			scrollClip._x = 1.5;
		} else {
			scrollClip._xscale = -100;
			scrollClip._x = maskClip._x+maskClip._width+scrollClip._width-3;
		}
		return scrollClip;
	}
	//
	private function scrollTrue():Void {
		scrolling = true;
	}
	private function scrollFalse():Void {
		scrolling = false;
	}
}
