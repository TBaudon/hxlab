#include <hxcpp.h>

#ifndef INCLUDED_Extension
#include <Extension.h>
#endif
#ifndef INCLUDED_haxe_Log
#include <haxe/Log.h>
#endif

Void Extension_obj::__construct()
{
HX_STACK_FRAME("Extension","new",0x1ae5afd1,"Extension.new","Extension.hx",9,0xeb74f4bf)
HX_STACK_THIS(this)
{
}
;
	return null();
}

//Extension_obj::~Extension_obj() { }

Dynamic Extension_obj::__CreateEmpty() { return  new Extension_obj; }
hx::ObjectPtr< Extension_obj > Extension_obj::__new()
{  hx::ObjectPtr< Extension_obj > _result_ = new Extension_obj();
	_result_->__construct();
	return _result_;}

Dynamic Extension_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< Extension_obj > _result_ = new Extension_obj();
	_result_->__construct();
	return _result_;}

Void Extension_obj::run( ){
{
		HX_STACK_FRAME("Extension","run",0x1ae8c6bc,"Extension.run","Extension.hx",13,0xeb74f4bf)
		HX_STACK_THIS(this)
		HX_STACK_LINE(14)
		Dynamic tmp = hx::SourceInfo(HX_HCSTRING("Extension.hx","\xbf","\xf4","\x74","\xeb"),14,HX_HCSTRING("Extension","\x5f","\x73","\xe3","\x86"),HX_HCSTRING("run","\x4b","\xe7","\x56","\x00"));		HX_STACK_VAR(tmp,"tmp");
		HX_STACK_LINE(14)
		::haxe::Log_obj::trace(HX_HCSTRING("it works!","\xf4","\xdb","\x2c","\x6c"),tmp);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC0(Extension_obj,run,(void))


Extension_obj::Extension_obj()
{
}

Dynamic Extension_obj::__Field(const ::String &inName,hx::PropertyAccess inCallProp)
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
	HX_MARK_MEMBER_NAME(Extension_obj::__mClass,"__mClass");
};

#ifdef HXCPP_VISIT_ALLOCS
static void sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(Extension_obj::__mClass,"__mClass");
};

#endif

hx::Class Extension_obj::__mClass;

void Extension_obj::__register()
{
	hx::Static(__mClass) = new hx::Class_obj();
	__mClass->mName = HX_HCSTRING("Extension","\x5f","\x73","\xe3","\x86");
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &hx::Class_obj::GetNoStaticField;
	__mClass->mSetStaticField = &hx::Class_obj::SetNoStaticField;
	__mClass->mMarkFunc = sMarkStatics;
	__mClass->mStatics = hx::Class_obj::dupFunctions(0 /* sStaticFields */);
	__mClass->mMembers = hx::Class_obj::dupFunctions(sMemberFields);
	__mClass->mCanCast = hx::TCanCast< Extension_obj >;
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

