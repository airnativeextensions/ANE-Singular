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
	import com.distriqt.extension.core.Core;
//	import com.distriqt.extension.idfa.IDFA;
//	import com.distriqt.extension.idfa.TrackingAuthorisationStatus;
//	import com.distriqt.extension.idfa.events.IDFAEvent;
	import com.distriqt.extension.inappbilling.Purchase;
	import com.singular.Singular;
	import com.singular.SingularAdData;
	import com.singular.SingularAttributes;
	import com.singular.SingularConfig;
	import com.singular.SingularEvents;
	import com.singular.events.SingularLinkEvent;

	import starling.display.Sprite;

	/**
	 */
	public class SingularTests extends Sprite
	{
		public static const TAG:String = "";

		private var _l:ILogger;

		private function log( log:String ):void
		{
			_l.log( TAG, log );
		}


		////////////////////////////////////////////////////////
		//	FUNCTIONALITY
		//

		public function SingularTests( logger:ILogger )
		{
			_l = logger;
			try
			{
				Core.init();

				log( "Singular Supported:     " + Singular.isSupported );
				if (!Singular.isSupported) return;

				log( "Singular.version:       " + Singular.service.version );
				log( "Singular.nativeVersion: " + Singular.service.nativeVersion );

				Singular.instance.addEventListener( SingularLinkEvent.RESOLVED, linkResolvedHandler );
			}
			catch (e:Error)
			{
				trace( e );
			}
		}


		public function getIDFA():void
		{
			log( "getIDFA()" );
//			IDFA.service.addEventListener( IDFAEvent.COMPLETE, idfaCompleteHandler );
//			IDFA.service.requestAuthorisation(
//					function ( status:String ):void
//					{
//						if (status == TrackingAuthorisationStatus.AUTHORISED)
//						{
//							IDFA.service.getIDFA();
//						}
//					}
//			);
		}

//		private function idfaCompleteHandler( event:IDFAEvent ):void
//		{
//			log( "identifier: " + event.identifier );
//			log( "isLimitAdTrackingEnabled: " + event.isLimitAdTrackingEnabled );
//		}


		////////////////////////////////////////////////////////
		//  
		//

		public function init():void
		{

			var config:SingularConfig = new SingularConfig( Config.apiKey, Config.secret )
					.withCustomUserId( "distriqt_tester_01" )
					.withLoggingEnabled()
					.withLogLevel( SingularConfig.LOG_DEBUG )
					.withGlobalProperty( "a_prop", "set from config", true )
					.withGlobalProperty( "b_prop", "set from config", true )
					.withSKAdNetworkEnabled( true )
					.withWaitForTrackingAuthorizationTimeoutInterval( 300 )
					.withSessionTimeoutInSec( 100 )
			;

			var success:Boolean = Singular.instance.init( config );

			log( "init() = " + success );
		}


		public function setCustomUserId():void
		{
			Singular.instance.setCustomUserId( "distriqt_tester_custom" );
		}


		public function unsetCustomUserId():void
		{
			Singular.instance.unsetCustomUserId();
		}


		private function linkResolvedHandler( event:SingularLinkEvent ):void
		{
			log( "linkResolvedHandler()" );
			log( event.params.deeplink );
		}


		public function logEvent():void
		{
			var args:Object = {};
			args[SingularAttributes.CONTENT] = "Tutorial name";
			args[SingularAttributes.CONTENT_ID] = "contentId";
			args[SingularAttributes.CONTENT_TYPE] = "type of content";
			args[SingularAttributes.SUCCESS] = true;

			var success:Boolean = Singular.instance.event( SingularEvents.TUTORIAL_COMPLETE, args );

			log( "logEvent() = " + success );

		}

		public function logEventNoAttributes():void
		{
			var success:Boolean = Singular.instance.event( SingularEvents.SUBSCRIBE );
			log( "logEventNoAttributes() = " + success );
		}


		public function logCustomEvent():void
		{
			var success:Boolean = Singular.instance.event(
					"bonus_points_earned",
					{
						"points": 500
					}
			);
			log( "logCustomEvent() = " + success );
		}


		public function logRevenue():void
		{
			var success:Boolean = Singular.instance.revenue(
					"AUD",
					1.99
			);
			log( "logRevenue() = " + success );
		}


		public function logRevenueFromInAppBilling():void
		{
//			var purchase:Purchase = new Purchase(); // TODO: Get your purchase object from InAppBilling v15.2.0+
//
//			var success:Boolean = Singular.instance.revenueWithPurchase(
//					purchase.toObject()
//			);
//			log( "logRevenueFromInAppBilling() = " + success );

			var purchaseObj:Object = {
				productId: "test.product",

				transactionId: "2000000519213703",
				transactionReceipt: "MIJxxQYJKoZIhvcNAQcCoIJxtjCCcbICAQExDzANBglghkgBZQMEAgEFADCCYPsGCSqGSIb3DQEHAaCCYOwEgmDoMYJg5DAKAgEIAgEBBAIWADAKAgEUAgEBBAIMADALAgEBAgEBBAMCAQAwCwIBCwIBAQQDAgEAMAsCAQ8CAQEEAwIBADALAgEQAgEBBAMCAQAwCwIBGQIBAQQDAgEDMAwCAQoCAQEEBBYCNCswDAIBDgIBAQQEAgIAizANAgENAgEBBAUCAwJNEDANAgETAgEBBAUMAzEuMDAOAgEJAgEBBAYCBFAzMDIwEwIBAwIBAQQLDAkxMjkuNC4yNTYwGAIBBAIBAgQQ/mw3xkYVtaRI12gi/1ArhDAbAgEAAgEBBBMMEVByb2R1Y3Rpb25TYW5kYm94MBwCAQUCAQEEFEBlr8JfS6zZ8562t086Ud//9blxMB4CAQwCAQEEFhYUMjAyNC0wMi0wN1QxNzo0ODowNVowHgIBEgIBAQQWFhQyMDEzLTA4LTAxVDA3OjAwOjAwWjAhAgECAgEBBBkMF2JyLmNvbS5tZWdham9nb3MubW9iaWxlMEUCAQcCAQEEPQpY/9CVKguWI9R62f8mlaDF1N/zPTPZHcpbrUPPxEhJjOGp++mqFJbYm+gttKkbh29752JBjpnpiPIRf3UwUgIBBgIBAQRK5Ju2n8Ym5CQ3yf61SlOvHNtDkNbQ1j96fGZLGODj/1ee7BtwfK3HR6hphDLri3xZ+JdekF7IXBDEI1oiQQiVNBPYxoUk0AZ3inEwggFtAgERAg<\\M-b\\M^@\\M-&>",
				signature: "aaaaaaaaaaaaaaaaaaaaaaa",

				product: {
					currencyCode: "AUD",
					price: 1.23
				}
			}
			var success:Boolean = Singular.instance.revenueWithPurchase(
					purchaseObj
			);
			log( "logRevenueFromInAppBilling() = " + success );

		}


		public function logRevenueCustom():void
		{
//			var product:Product = new Product(); // product from InAppBilling
//			var purchase:Purchase = new Purchase(); // purchase object from InAppBilling
//
//			var args:Object = {};
//			args["is_revenue_event"] = true;
//			args["pcc"] = product.currencyCode;
//			if (Singular.instance.implementation == "iOS")
//			{
//				args["pti"] = purchase.transactionId;
//				args["ptr"] = purchase.transactionReceipt;
//				args["pk"] = purchase.productId;
//				args["pp"] = product.price;
//			}
//			else
//			{
//				args["receipt_signature"] = purchase.signature;
//				args["receipt"] = purchase.transactionId;
//				args["r"] = product.price;
//			}
//
//			var success:Boolean = Singular.instance.event( "__iap__", args );
		}


		public function logRevenueWithProduct():void
		{
			var success:Boolean = Singular.instance.revenue(
					"AUD",
					0.86,
					"product_id",
					"test product",
					"testing_cat",
					1,
					0.86
			);

			log( "logRevenueWithProduct() = " + success );
		}


		public function createReferrerShortLink():void
		{
			log( "createReferrerShortLink()" );
			Singular.instance.createReferrerShortLink(
					"https://sample.sng.link/D52wc/cuvk?pcn=test",
					"Singular Test App",
					"singular_test_app",
					{
						"param": "value"
					},
					function ( success:Boolean, data:String ):void
					{
						log( "createReferrerShortLink: " + success + " :: " + data );
					}
			);
		}


		public function adRevenue():void
		{
			log( "adRevenue()" );

			var data:SingularAdData = new SingularAdData( SingularAdData.ADMOB, "USD", 1.23 )
					.withAdUnitId( "admob-unit-id" )
					.withNetworkName( "mediation-adapter-name" )

			Singular.instance.adRevenue( data );
		}


		public function setDeviceToken():void
		{
			log( "setDeviceToken()" );
			Singular.instance.setDeviceToken( "your_fcm_or_ios_device_token" );
		}


		public function getGlobalProperties():void
		{
			log( "getGlobalProperties()" );
			var props:Object = Singular.instance.getGlobalProperties();
			for (var key:String in props)
			{
				log( key + " = " + props[key] );
			}
		}

		public function setGlobalProperty():void
		{
			log( "setGlobalProperty()" );
			Singular.instance.setGlobalProperty( "a_prop", "set from sdk", true );
		}

		public function unsetGlobalProperty():void
		{
			log( "unsetGlobalProperty()" );
			Singular.instance.unsetGlobalProperty( "a_prop" );
		}

		public function clearGlobalProperties():void
		{
			log( "clearGlobalProperties()" );
			Singular.instance.clearGlobalProperties();
		}


		public function getLimitDataSharing():void
		{
			log( "limitDataSharing = " + Singular.instance.getLimitDataSharing() );
		}

		public function setLimitDataSharing():void
		{
			log( "limitDataSharing()" );
			Singular.instance.limitDataSharing( true );
		}


		public function trackingOptIn():void
		{
			log( "trackingOptIn()" );
			Singular.instance.trackingOptIn();
		}

		public function stopAllTracking():void
		{
			log( "stopAllTracking()" );
			Singular.instance.stopAllTracking();
		}

		public function resumeAllTracking():void
		{
			log( "resumeAllTracking()" );
			Singular.instance.resumeAllTracking();
		}

		public function isAllTrackingStopped():void
		{
			log( "isAllTrackingStopped = " + Singular.instance.isAllTrackingStopped() );
		}

	}
}
