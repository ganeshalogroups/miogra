# --- Razorpay Support ---
-keep class com.razorpay.** { *; }
-dontwarn com.razorpay.**
-keepattributes *Annotation*
-keepclassmembers class * {
  public void onDataChange(...);
  public void onCancelled(...);
}
-optimizations !method/inlining/*
-keepclasseswithmembers class * {
  public void onPayment*(...);
}

# --- Twilio Support ---
-keep class com.twilio.** { *; }
-dontwarn com.twilio.**
-keep class tvi.webrtc.** { *; }
-dontwarn tvi.webrtc.**
-keepattributes Signature,RuntimeVisibleAnnotations,AnnotationDefault

# Retain enums and inner class info for Twilio
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}
