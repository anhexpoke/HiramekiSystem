import skyui.widgets.WidgetBase;
import skyui.util.Tween;

import Shared.GlobalFunc;

class HiramekiWidget extends WidgetBase{
	
	//ステージエレメント
	var _xscale, _yscale;
	
	public var _labelTextField: TextField;
	
	private var _labelText: String;
	
	public var popup: MovieClip
	public var cutin: MovieClip
	
	//コンストラクタ
	public function HiramekiWidget(){
		super();
		popup._visible = false;
		cutin._visible = false;
	}

	// @Papyrus
	public function setVisible(a_visible: Boolean): Void{
		popup._visible = a_visible;
		cutin._visible = a_visible;
		_visible = a_visible;
	}
	
	// @overrides WidgetBase
	public function getWidth(): Number{
		return _width;
	}
	
	// @overrides WidgetBase
	public function getHeight(): Number{
		return _height;
	}
	
	// @Papyrus
	public function setLabelText(a_val: String): Void{
		if(_labelText == a_val)
			return
		popup._labelTextField.text = _labelText = a_val;
	}
	
	// @Papyrus
	public function cutIn(a_newX: Number, a_newY: Number, a_duration: Number): Void{
		var newX: Number = GlobalFunc.Lerp(-_hudMetrics.hMin, _hudMetrics.hMax, 0, 1280, a_newX);
		var newY: Number = GlobalFunc.Lerp(-_hudMetrics.vMin, _hudMetrics.vMax, 0, 720, a_newY);
		var duration: Number = Math.max(0, a_duration || 0);

		Tween.LinearTween(cutin, "_x", cutin._x, newX, duration, null);
		Tween.LinearTween(cutin, "_y", cutin._y, newY, duration, null);
	}
	
	function get Scale(){
		return (_xscale);
	}
	
	function set Scale(scale){
		_xscale = scale;
		_yscale = scale;
		this.invalidateSize();
		//
		null;
	}
}