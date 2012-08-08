/*
 * TinyURL Flex Library
 * Copyright © 2008-2012 Nick Schneble
 */
package com.njs.tinyurl
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;


	/**
	 * A static method for creating TinyURLs.
	 * 
	 * <p>To use, simply pass a URL string and a callback method into the
	 * <code>TinyURL.create()</code> method. The callback will be invoked
	 * once the TinyURL has been created.</p>
	 * 
	 * <p>The callback method should have the following signature:</p>
	 * <p><code>function callback (tinyURL : String) : void;</code></p>
	 * 
	 * <p>If anything goes wrong, the original URL will be returned.</p>
	 */
	public class TinyURL
	{
		// instance variables

		/**
		 * Stores TinyLoader objects while URLs are being shortened.
		 */
		private static var loaders : Array = [];


		// public methods

		/**
		 * Creates a TinyURL.
		 * 
		 * @param url The URL to shorten
		 * @param callback A callback method to return the TinyURL
		 */
		public static function create (url : String, callback : Function) : void
		{
			var loader : TinyLoader = new TinyLoader (url, callback);
			loaders.push (loader);

			loader.addEventListener (Event.COMPLETE, onTinySuccess);
			loader.addEventListener (IOErrorEvent.IO_ERROR, onTinyFailure);
			loader.addEventListener (SecurityErrorEvent.SECURITY_ERROR, onTinyFailure);
		}


		// event handlers

		/**
		 * Invoked when a TinyURL is successfully created.
		 * 
		 * @param event An event with details about the success
		 */
		private static function onTinySuccess (event : Event) : void
		{
			var loader : TinyLoader = event.target as TinyLoader;
			loaders.splice (loaders.indexOf (loader), 1);

			// invokes the callback method with the shortened URL
			if (loader.callback != null)
			{
				loader.callback (loader.data as String);
			}
		}

		/**
		 * Invoked when a TinyURL fails to be created.
		 * 
		 * @param event An event with details about the failure
		 */
		private static function onTinyFailure (event : Event) : void
		{
			var loader : TinyLoader = event.target as TinyLoader;
			loaders.splice (loaders.indexOf (loader), 1);

			// invokes the callback method with the original URL
			if (loader.callback != null)
			{
				loader.callback (loader.url);
			}
		}

	}
}
