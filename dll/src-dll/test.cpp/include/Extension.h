#ifndef INCLUDED_Extension
#define INCLUDED_Extension

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS0(Extension)


class HXCPP_CLASS_ATTRIBUTES  Extension_obj : public hx::Object{
	public:
		typedef hx::Object super;
		typedef Extension_obj OBJ_;
		Extension_obj();
		Void __construct();

	public:
		inline void *operator new( size_t inSize, bool inContainer=false,const char *inName="Extension")
			{ return hx::Object::operator new(inSize,inContainer,inName); }
		static hx::ObjectPtr< Extension_obj > __new();
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		//~Extension_obj();

		HX_DO_RTTI_ALL;
		Dynamic __Field(const ::String &inString, hx::PropertyAccess inCallProp);
		static void __register();
		::String __ToString() const { return HX_HCSTRING("Extension","\x5f","\x73","\xe3","\x86"); }

		virtual Void run( );
		Dynamic run_dyn();

};


#endif /* INCLUDED_Extension */ 
