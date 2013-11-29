     /**
 *	Copyright (C) 2004-2009 WeMB INC. 
 *	All Rights Reserved.
 *	@date			:	2009-04-07
 *	@auther			:	고재학
 *	@ver			:	1.0
 *	@description 	:	
 *	
**/
package com.wemb.tobit.pure.controller
{
	import org.puremvc.as3.patterns.command.MacroCommand;

	public class ApplicationStartupCommand extends MacroCommand
	{
		public function ApplicationStartupCommand()
		{
			super();
		}
		
		override protected function initializeMacroCommand():void{
			addSubCommand(ModelPrepCommand);
		}
	}
}