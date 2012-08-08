/*
 * TinyURL Flex Library
 * Copyright © 2008-2012 Nick Schneble
 */
package com.njs.tinyurl
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;


	/**
	 * TinyLoader is used to convert urls to TinyURLs.
	 * 
	 * <p>You shouldn't need to interact with this class directly; it's used by the <code>TinyURL</code> class.</p>
	 */
	public class TinyLoader extends URLLoader
	{
		// constants

		/**
		 * The API URL for creating TinyURLs.
		 */
		private static const CREATE_TINYURL_API_URL : String = "http://tinyurl.com/api-create.php?url=";


		// instance variables

		/**
		 * The URL to shorten.
		 */
		public var url : String;

		/**
		 * A callback method to return the TinyURL.
		 */
		public var callback : Function;


		/**
		 * Creates a TinyLoader object.
		 * 
		 * @param url The URL to shorten
		 * @param callback A callback method to return the TinyURL
		 */
		public function TinyLoader (url : String, callback : Function)
		{
			this.url = url ? url : "";
			this.callback = callback;

			super (new URLRequest (CREATE_TINYURL_API_URL + encodeURIComponent (url)));
		}

	}
}
