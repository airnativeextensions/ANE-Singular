/**
 *        __       __               __
 *   ____/ /_ ____/ /______ _ ___  / /_
 *  / __  / / ___/ __/ ___/ / __ `/ __/
 * / /_/ / (__  ) / / /  / / /_/ / /
 * \__,_/_/____/_/ /_/  /_/\__, /_/
 *                           / /
 *                           \/
 * https://distriqt.com
 *
 * @author 		Michael Archbold (https://github.com/marchbold)
 * @created		14/04/2023
 * @copyright	https://distriqt.com/copyright/license.txt
 */
package com.distriqt.test.singular
{
	import feathers.controls.Button;
	import feathers.controls.ScrollContainer;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.VerticalAlign;
	import feathers.layout.VerticalLayout;
	import feathers.themes.MetalWorksMobileTheme;

	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.text.TextFormat;
	import starling.utils.Color;

	/**
	 *
	 */
	public class Main extends Sprite implements ILogger
	{
		////////////////////////////////////////////////////////
		//	CONSTANTS
		//


		////////////////////////////////////////////////////////
		//	VARIABLES
		//

		private var _tests:SingularTests;

		private var _text:TextField;
		private var _container:ScrollContainer;


		////////////////////////////////////////////////////////
		//	FUNCTIONALITY
		//


		/**
		 *  Constructor
		 */
		public function Main()
		{
			super();
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
		}


		public function log( tag:String, message:String ):void
		{
			trace( tag + "::" + message );
			if (_text)
				_text.text = tag + "::" + message + "\n" + _text.text;
		}


		////////////////////////////////////////////////////////
		//	INTERNALS
		//


		private function createUI():void
		{
			var tf:TextFormat = new TextFormat( "_typewriter", 12, Color.WHITE, HorizontalAlign.LEFT, VerticalAlign.TOP );
			_text = new TextField( stage.stageWidth, stage.stageHeight, "", tf );
			_text.y = 40;
			_text.touchable = false;

			var layout:VerticalLayout = new VerticalLayout();
			layout.horizontalAlign = HorizontalAlign.RIGHT;
			layout.verticalAlign = VerticalAlign.BOTTOM;
			layout.gap = 5;

			_container = new ScrollContainer();
			_container.y = 40;
			_container.layout = layout;
			_container.width = stage.stageWidth;
			_container.height = stage.stageHeight - 80;


			_tests = new SingularTests( this );

			addAction( "Get IDFA", _tests.getIDFA );

			addAction( "Init", _tests.init );
			addAction( "set :CustomUserId", _tests.setCustomUserId );
			addAction( "unset :CustomUserId", _tests.unsetCustomUserId );
			addAction( "standard :Event", _tests.logEvent );
			addAction( "standard no attr :Event", _tests.logEventNoAttributes );
			addAction( "custom :Event", _tests.logCustomEvent );
			addAction( "revenue  :Event", _tests.logRevenue );
			addAction( "revenue from IAP :Event", _tests.logRevenueFromInAppBilling );
			addAction( "revenue w product :Event", _tests.logRevenueWithProduct );
			addAction( "create referrer short link", _tests.createReferrerShortLink );
			addAction( "ad revenue", _tests.adRevenue );

			addAction( "setDeviceToken", _tests.setDeviceToken );

			addAction( "get :GlobalProperties", _tests.getGlobalProperties );
			addAction( "set :GlobalProperties", _tests.setGlobalProperty );
			addAction( "unset :GlobalProperties", _tests.unsetGlobalProperty );
			addAction( "clear :GlobalProperties", _tests.clearGlobalProperties );


			addAction( "get :LimitDataSharing", _tests.getLimitDataSharing );
			addAction( "set :LimitDataSharing", _tests.setLimitDataSharing );

			addAction( "opt in :Tracking", _tests.trackingOptIn );
			addAction( "stop :Tracking", _tests.stopAllTracking );
			addAction( "resume :Tracking", _tests.resumeAllTracking );
			addAction( "get :Tracking", _tests.isAllTrackingStopped );


			addChild( _tests );
			addChild( _text );
			addChild( _container );
		}


		private function addAction( label:String, listener:Function ):void
		{
			var b:Button = new Button();
			b.label = label;
			b.addEventListener( Event.TRIGGERED, listener );
			_container.addChild( b );
		}


		////////////////////////////////////////////////////////
		//	EVENT HANDLERS
		//

		protected function addedToStageHandler( event:Event ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			new MetalWorksMobileTheme();
			createUI();
		}


	}
}