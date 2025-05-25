# Ignore missing Proguard annotation classes
-dontwarn proguard.annotation.**

# Keep all classes for Razorpay
-dontwarn com.razorpay.**
-keep class com.razorpay.** { *; }

# Keep annotation attributes
-keepattributes *Annotation*

# Disable method inlining optimizations
-optimizations !method/inlining/

# Keep classes with payment callback methods
-keepclasseswithmembers class * {
    public void onPayment*(...);
}
