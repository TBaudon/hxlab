#include <hxcpp.h>

#ifndef INCLUDED_haxe_Log
#include <haxe/Log.h>
#endif
#ifndef INCLUDED_Std
#include <Std.h>
#endif
#ifndef INCLUDED_App
#include <App.h>
#endif
#ifndef INCLUDED_Extension
#include <Extension.h>
#endif

void __files__boot();

void __boot_all()
{
__files__boot();
hx::RegisterResources( hx::GetResources() );
::haxe::Log_obj::__register();
::Std_obj::__register();
::App_obj::__register();
::Extension_obj::__register();
::haxe::Log_obj::__boot();
}

