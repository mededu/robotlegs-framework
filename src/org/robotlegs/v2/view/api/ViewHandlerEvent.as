//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package org.robotlegs.v2.view.api
{
	import flash.events.Event;

	public class ViewHandlerEvent extends Event
	{

		/*============================================================================*/
		/* Public Static Properties                                                   */
		/*============================================================================*/

		public static const CONFIGURATION_CHANGE:String = 'configurationChange';

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		public function ViewHandlerEvent(type:String)
		{
			super(type);
		}


		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		override public function clone():Event
		{
			return new ViewHandlerEvent(type);
		}
	}
}
