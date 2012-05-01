//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.viewManager.impl
{
	import flash.display.DisplayObjectContainer;
	import robotlegs.bender.extensions.viewManager.api.IViewHandler;
	import robotlegs.bender.extensions.viewManager.api.IViewManager;

	public class ViewManager implements IViewManager
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private const _containers:Vector.<DisplayObjectContainer> = new Vector.<DisplayObjectContainer>;

		private const _handlers:Vector.<IViewHandler> = new Vector.<IViewHandler>;

		private var _registry:ContainerRegistry;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		public function ViewManager(containerRegistry:ContainerRegistry)
		{
			_registry = containerRegistry;
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		public function addContainer(container:DisplayObjectContainer):void
		{
			if (!validContainer(container))
				return;

			_containers.push(container);

			for each (var handler:IViewHandler in _handlers)
			{
				_registry.addContainer(container).addHandler(handler);
			}
		}

		public function removeContainer(container:DisplayObjectContainer):void
		{
			const index:int = _containers.indexOf(container);
			if (index == -1)
				return;

			_containers.splice(index, 1);

			const binding:ContainerBinding = _registry.getBinding(container);
			for each (var handler:IViewHandler in _handlers)
			{
				binding.removeHandler(handler);
			}
		}

		public function addViewHandler(handler:IViewHandler):void
		{
			if (_handlers.indexOf(handler) != -1)
				return;

			_handlers.push(handler);

			for each (var container:DisplayObjectContainer in _containers)
			{
				_registry.addContainer(container).addHandler(handler);
			}
		}

		public function removeViewHandler(handler:IViewHandler):void
		{
			const index:int = _handlers.indexOf(handler);
			if (index == -1)
				return;

			_handlers.splice(index, 1);

			for each (var container:DisplayObjectContainer in _containers)
			{
				_registry.getBinding(container).removeHandler(handler);
			}
		}

		public function removeAllHandlers():void
		{
			for each (var container:DisplayObjectContainer in _containers)
			{
				const binding:ContainerBinding = _registry.getBinding(container);
				for each (var handler:IViewHandler in _handlers)
				{
					binding.removeHandler(handler);
				}
			}
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/

		private function validContainer(container:DisplayObjectContainer):Boolean
		{
			for each (var registeredContainer:DisplayObjectContainer in _containers)
			{
				if (container == registeredContainer)
					return false;

				if (registeredContainer.contains(container) || container.contains(registeredContainer))
					throw new Error("Containers can not be nested");
			}
			return true;
		}
	}
}