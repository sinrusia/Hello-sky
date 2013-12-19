////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2004-2012 WeMB INC.
//  All Rights Reserved.
//
////////////////////////////////////////////////////////////////////////////////
package com.wemb.tobit.pure.controller
{
	import com.wemb.puremvc.patterns.command.MacroCommand;

	public class ApplicationStartupCommand extends MacroCommand
	{
		public function ApplicationStartupCommand()
		{
			super();
		}
		
		override protected function initializeMacroCommand():void
		{
			super.initializeMacroCommand();
			addSubCommand(ModelPrepCommand);
			addSubCommand(TobitInitCommand);
		}
	}
}