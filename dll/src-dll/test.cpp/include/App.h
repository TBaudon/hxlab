#ifndef INCLUDED_App
#define INCLUDED_App

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#ifndef INCLUDED_Extension
#include <Extension.h>
#endif
HX_DECLARE_CLASS0(App)
HX_DECLARE_CLASS0(Extension)


class HXCPP_CLASS_ATTRIBUTES  App_obj : public ::Extension_obj{
	public:
		typedef ::Extension_obj super;
		typedef App_obj OBJ_;
		App_obj();
		Void __construct();

	public:
		inline void *operator new( size_t inSize, bool inContainer=false,const char *inName="App")
			{ return hx::Object::operator new(inSize,inContainer,inName); }
		static hx::ObjectPtr< App_obj > __new();
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		//~App_obj();

		HX_DO_RTTI_ALL;
		Dynamic __Field(const ::String &inString, hx::PropertyAccess inCallProp);
		static void __register();
		::String __ToString() const { return HX_HCSTRING("App","\x81","\xb4","\x31","\x00"); }

		virtual Void run( );

};


#endif /* INCLUDED_App */ 
