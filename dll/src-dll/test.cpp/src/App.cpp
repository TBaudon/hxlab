#include <hxcpp.h>

#ifndef INCLUDED_App
#include <App.h>
#endif
#ifndef INCLUDED_Extension
#include <Extension.h>
#endif
#ifndef INCLUDED_haxe_Log
#include <haxe/Log.h>
#endif

Void App_obj::__construct()
{
HX_STACK_FRAME("App","new",0xf28829f3,"App.new","App.hx",10,0xc43e94dd)
HX_STACK_THIS(this)
{
	HX_STACK_LINE(10)
	super::__construct();
}
;
	return null();
}

//App_obj::~App_obj() { }

Dynamic App_obj::__CreateEmpty() { return  new App_obj; }
hx::ObjectPtr< App_obj > App_obj::__new()
{  hx::ObjectPtr< App_obj > _result_ = new App_obj();
	_result_->__construct();
	return _result_;}

Dynamic App_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< App_obj > _result_ = new App_obj();
	_result_->__construct();
	return _result_;}

Void App_obj::run( ){
{
		HX_STACK_FRAME("App","run",0xf28b40de,"App.run","App.hx",13,0xc43e94dd)
		HX_STACK_THIS(this)
		HX_STACK_LINE(14)
		this->super::run();
		HX_STACK_LINE(16)
		Dynamic tmp = hx::SourceInfo(HX_HCSTRING("App.hx","\xdd","\x94","\x3e","\xc4"),16,HX_HCSTRING("App","\x81","\xb4","\x31","\x00"),HX_HCSTRING("run","\x4b","\xe7","\x56","\x00"));		HX_STACK_VAR(tmp,"tmp");
		HX_STACK_LINE(16)
		::haxe::Log_obj::trace(HX_HCSTRING("Oh yes it does!","\xb3","\xd8","\x8f","\x69"),tmp);
	}
return null();
}



App_obj::App_obj()
{
}

Dynamic App_obj::__Field(const ::String &inName,hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 3:
		if (HX_FIELD_EQ(inName,"run") ) { return run_dyn(); }
	}
	return super::__Field(inName,inCallProp);
}

#if HXCPP_SCRIPTABLE
static hx::StorageInfo *sMemberStorageInfo = 0;
static hx::StaticInfo *sStaticStorageInfo = 0;
#endif

static ::String sMemberFields[] = {
	HX_HCSTRING("run","\x4b","\xe7","\x56","\x00"),
	::String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(App_obj::__mClass,"__mClass");
};

#ifdef HXCPP_VISIT_ALLOCS
static void sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(App_obj::__mClass,"__mClass");
};

#endif

hx::Class App_obj::__mClass;

void App_obj::__register()
{
	hx::Static(__mClass) = new hx::Class_obj();
	__mClass->mName = HX_HCSTRING("App","\x81","\xb4","\x31","\x00");
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &hx::Class_obj::GetNoStaticField;
	__mClass->mSetStaticField = &hx::Class_obj::SetNoStaticField;
	__mClass->mMarkFunc = sMarkStatics;
	__mClass->mStatics = hx::Class_obj::dupFunctions(0 /* sStaticFields */);
	__mClass->mMembers = hx::Class_obj::dupFunctions(sMemberFields);
	__mClass->mCanCast = hx::TCanCast< App_obj >;
#ifdef HXCPP_VISIT_ALLOCS
	__mClass->mVisitFunc = sVisitStatics;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mMemberStorageInfo = sMemberStorageInfo;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mStaticStorageInfo = sStaticStorageInfo;
#endif
	hx::RegisterClass(__mClass->mName, __mClass);
}

