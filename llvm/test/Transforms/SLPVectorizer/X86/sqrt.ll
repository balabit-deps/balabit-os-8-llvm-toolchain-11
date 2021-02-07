; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -mtriple=x86_64-unknown -basic-aa -slp-vectorizer -S | FileCheck %s --check-prefix=CHECK --check-prefix=SSE
; RUN: opt < %s -mtriple=x86_64-unknown -mattr=avx -basic-aa -slp-vectorizer -S | FileCheck %s --check-prefix=CHECK --check-prefix=AVX --check-prefix=AVX256
; RUN: opt < %s -mtriple=x86_64-unknown -mattr=avx2 -basic-aa -slp-vectorizer -S | FileCheck %s --check-prefix=CHECK --check-prefix=AVX --check-prefix=AVX256
; RUN: opt < %s -mtriple=x86_64-unknown -mattr=avx512vl,avx512dq,avx512bw -basic-aa -slp-vectorizer -S | FileCheck %s --check-prefix=CHECK --check-prefix=AVX --check-prefix=AVX512

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

@src64 = common global [8 x double] zeroinitializer, align 64
@src32 = common global [16 x float] zeroinitializer, align 64
@dst64 = common global [8 x double] zeroinitializer, align 64
@dst32 = common global [16 x float] zeroinitializer, align 64

declare float @llvm.sqrt.f32(float)
declare double @llvm.sqrt.f64(double)

;
; SQRT
;

define void @sqrt_2f64() #0 {
; CHECK-LABEL: @sqrt_2f64(
; CHECK-NEXT:    [[TMP1:%.*]] = load <2 x double>, <2 x double>* bitcast ([8 x double]* @src64 to <2 x double>*), align 8
; CHECK-NEXT:    [[TMP2:%.*]] = call <2 x double> @llvm.sqrt.v2f64(<2 x double> [[TMP1]])
; CHECK-NEXT:    store <2 x double> [[TMP2]], <2 x double>* bitcast ([8 x double]* @dst64 to <2 x double>*), align 8
; CHECK-NEXT:    ret void
;
  %a0 = load double, double* getelementptr inbounds ([8 x double], [8 x double]* @src64, i32 0, i64 0), align 8
  %a1 = load double, double* getelementptr inbounds ([8 x double], [8 x double]* @src64, i32 0, i64 1), align 8
  %sqrt0 = call double @llvm.sqrt.f64(double %a0)
  %sqrt1 = call double @llvm.sqrt.f64(double %a1)
  store double %sqrt0, double* getelementptr inbounds ([8 x double], [8 x double]* @dst64, i32 0, i64 0), align 8
  store double %sqrt1, double* getelementptr inbounds ([8 x double], [8 x double]* @dst64, i32 0, i64 1), align 8
  ret void
}

define void @sqrt_4f64() #0 {
; SSE-LABEL: @sqrt_4f64(
; SSE-NEXT:    [[TMP1:%.*]] = load <2 x double>, <2 x double>* bitcast ([8 x double]* @src64 to <2 x double>*), align 8
; SSE-NEXT:    [[TMP2:%.*]] = load <2 x double>, <2 x double>* bitcast (double* getelementptr inbounds ([8 x double], [8 x double]* @src64, i32 0, i64 2) to <2 x double>*), align 8
; SSE-NEXT:    [[TMP3:%.*]] = call <2 x double> @llvm.sqrt.v2f64(<2 x double> [[TMP1]])
; SSE-NEXT:    [[TMP4:%.*]] = call <2 x double> @llvm.sqrt.v2f64(<2 x double> [[TMP2]])
; SSE-NEXT:    store <2 x double> [[TMP3]], <2 x double>* bitcast ([8 x double]* @dst64 to <2 x double>*), align 8
; SSE-NEXT:    store <2 x double> [[TMP4]], <2 x double>* bitcast (double* getelementptr inbounds ([8 x double], [8 x double]* @dst64, i32 0, i64 2) to <2 x double>*), align 8
; SSE-NEXT:    ret void
;
; AVX-LABEL: @sqrt_4f64(
; AVX-NEXT:    [[TMP1:%.*]] = load <4 x double>, <4 x double>* bitcast ([8 x double]* @src64 to <4 x double>*), align 8
; AVX-NEXT:    [[TMP2:%.*]] = call <4 x double> @llvm.sqrt.v4f64(<4 x double> [[TMP1]])
; AVX-NEXT:    store <4 x double> [[TMP2]], <4 x double>* bitcast ([8 x double]* @dst64 to <4 x double>*), align 8
; AVX-NEXT:    ret void
;
  %a0 = load double, double* getelementptr inbounds ([8 x double], [8 x double]* @src64, i32 0, i64 0), align 8
  %a1 = load double, double* getelementptr inbounds ([8 x double], [8 x double]* @src64, i32 0, i64 1), align 8
  %a2 = load double, double* getelementptr inbounds ([8 x double], [8 x double]* @src64, i32 0, i64 2), align 8
  %a3 = load double, double* getelementptr inbounds ([8 x double], [8 x double]* @src64, i32 0, i64 3), align 8
  %sqrt0 = call double @llvm.sqrt.f64(double %a0)
  %sqrt1 = call double @llvm.sqrt.f64(double %a1)
  %sqrt2 = call double @llvm.sqrt.f64(double %a2)
  %sqrt3 = call double @llvm.sqrt.f64(double %a3)
  store double %sqrt0, double* getelementptr inbounds ([8 x double], [8 x double]* @dst64, i32 0, i64 0), align 8
  store double %sqrt1, double* getelementptr inbounds ([8 x double], [8 x double]* @dst64, i32 0, i64 1), align 8
  store double %sqrt2, double* getelementptr inbounds ([8 x double], [8 x double]* @dst64, i32 0, i64 2), align 8
  store double %sqrt3, double* getelementptr inbounds ([8 x double], [8 x double]* @dst64, i32 0, i64 3), align 8
  ret void
}

define void @sqrt_8f64() #0 {
; SSE-LABEL: @sqrt_8f64(
; SSE-NEXT:    [[TMP1:%.*]] = load <2 x double>, <2 x double>* bitcast ([8 x double]* @src64 to <2 x double>*), align 4
; SSE-NEXT:    [[TMP2:%.*]] = load <2 x double>, <2 x double>* bitcast (double* getelementptr inbounds ([8 x double], [8 x double]* @src64, i32 0, i64 2) to <2 x double>*), align 4
; SSE-NEXT:    [[TMP3:%.*]] = load <2 x double>, <2 x double>* bitcast (double* getelementptr inbounds ([8 x double], [8 x double]* @src64, i32 0, i64 4) to <2 x double>*), align 4
; SSE-NEXT:    [[TMP4:%.*]] = load <2 x double>, <2 x double>* bitcast (double* getelementptr inbounds ([8 x double], [8 x double]* @src64, i32 0, i64 6) to <2 x double>*), align 4
; SSE-NEXT:    [[TMP5:%.*]] = call <2 x double> @llvm.sqrt.v2f64(<2 x double> [[TMP1]])
; SSE-NEXT:    [[TMP6:%.*]] = call <2 x double> @llvm.sqrt.v2f64(<2 x double> [[TMP2]])
; SSE-NEXT:    [[TMP7:%.*]] = call <2 x double> @llvm.sqrt.v2f64(<2 x double> [[TMP3]])
; SSE-NEXT:    [[TMP8:%.*]] = call <2 x double> @llvm.sqrt.v2f64(<2 x double> [[TMP4]])
; SSE-NEXT:    store <2 x double> [[TMP5]], <2 x double>* bitcast ([8 x double]* @dst64 to <2 x double>*), align 4
; SSE-NEXT:    store <2 x double> [[TMP6]], <2 x double>* bitcast (double* getelementptr inbounds ([8 x double], [8 x double]* @dst64, i32 0, i64 2) to <2 x double>*), align 4
; SSE-NEXT:    store <2 x double> [[TMP7]], <2 x double>* bitcast (double* getelementptr inbounds ([8 x double], [8 x double]* @dst64, i32 0, i64 4) to <2 x double>*), align 4
; SSE-NEXT:    store <2 x double> [[TMP8]], <2 x double>* bitcast (double* getelementptr inbounds ([8 x double], [8 x double]* @dst64, i32 0, i64 6) to <2 x double>*), align 4
; SSE-NEXT:    ret void
;
; AVX256-LABEL: @sqrt_8f64(
; AVX256-NEXT:    [[TMP1:%.*]] = load <4 x double>, <4 x double>* bitcast ([8 x double]* @src64 to <4 x double>*), align 4
; AVX256-NEXT:    [[TMP2:%.*]] = load <4 x double>, <4 x double>* bitcast (double* getelementptr inbounds ([8 x double], [8 x double]* @src64, i32 0, i64 4) to <4 x double>*), align 4
; AVX256-NEXT:    [[TMP3:%.*]] = call <4 x double> @llvm.sqrt.v4f64(<4 x double> [[TMP1]])
; AVX256-NEXT:    [[TMP4:%.*]] = call <4 x double> @llvm.sqrt.v4f64(<4 x double> [[TMP2]])
; AVX256-NEXT:    store <4 x double> [[TMP3]], <4 x double>* bitcast ([8 x double]* @dst64 to <4 x double>*), align 4
; AVX256-NEXT:    store <4 x double> [[TMP4]], <4 x double>* bitcast (double* getelementptr inbounds ([8 x double], [8 x double]* @dst64, i32 0, i64 4) to <4 x double>*), align 4
; AVX256-NEXT:    ret void
;
; AVX512-LABEL: @sqrt_8f64(
; AVX512-NEXT:    [[TMP1:%.*]] = load <8 x double>, <8 x double>* bitcast ([8 x double]* @src64 to <8 x double>*), align 4
; AVX512-NEXT:    [[TMP2:%.*]] = call <8 x double> @llvm.sqrt.v8f64(<8 x double> [[TMP1]])
; AVX512-NEXT:    store <8 x double> [[TMP2]], <8 x double>* bitcast ([8 x double]* @dst64 to <8 x double>*), align 4
; AVX512-NEXT:    ret void
;
  %a0 = load double, double* getelementptr inbounds ([8 x double], [8 x double]* @src64, i32 0, i64 0), align 4
  %a1 = load double, double* getelementptr inbounds ([8 x double], [8 x double]* @src64, i32 0, i64 1), align 4
  %a2 = load double, double* getelementptr inbounds ([8 x double], [8 x double]* @src64, i32 0, i64 2), align 4
  %a3 = load double, double* getelementptr inbounds ([8 x double], [8 x double]* @src64, i32 0, i64 3), align 4
  %a4 = load double, double* getelementptr inbounds ([8 x double], [8 x double]* @src64, i32 0, i64 4), align 4
  %a5 = load double, double* getelementptr inbounds ([8 x double], [8 x double]* @src64, i32 0, i64 5), align 4
  %a6 = load double, double* getelementptr inbounds ([8 x double], [8 x double]* @src64, i32 0, i64 6), align 4
  %a7 = load double, double* getelementptr inbounds ([8 x double], [8 x double]* @src64, i32 0, i64 7), align 4
  %sqrt0 = call double @llvm.sqrt.f64(double %a0)
  %sqrt1 = call double @llvm.sqrt.f64(double %a1)
  %sqrt2 = call double @llvm.sqrt.f64(double %a2)
  %sqrt3 = call double @llvm.sqrt.f64(double %a3)
  %sqrt4 = call double @llvm.sqrt.f64(double %a4)
  %sqrt5 = call double @llvm.sqrt.f64(double %a5)
  %sqrt6 = call double @llvm.sqrt.f64(double %a6)
  %sqrt7 = call double @llvm.sqrt.f64(double %a7)
  store double %sqrt0, double* getelementptr inbounds ([8 x double], [8 x double]* @dst64, i32 0, i64 0), align 4
  store double %sqrt1, double* getelementptr inbounds ([8 x double], [8 x double]* @dst64, i32 0, i64 1), align 4
  store double %sqrt2, double* getelementptr inbounds ([8 x double], [8 x double]* @dst64, i32 0, i64 2), align 4
  store double %sqrt3, double* getelementptr inbounds ([8 x double], [8 x double]* @dst64, i32 0, i64 3), align 4
  store double %sqrt4, double* getelementptr inbounds ([8 x double], [8 x double]* @dst64, i32 0, i64 4), align 4
  store double %sqrt5, double* getelementptr inbounds ([8 x double], [8 x double]* @dst64, i32 0, i64 5), align 4
  store double %sqrt6, double* getelementptr inbounds ([8 x double], [8 x double]* @dst64, i32 0, i64 6), align 4
  store double %sqrt7, double* getelementptr inbounds ([8 x double], [8 x double]* @dst64, i32 0, i64 7), align 4
  ret void
}

define void @sqrt_4f32() #0 {
; CHECK-LABEL: @sqrt_4f32(
; CHECK-NEXT:    [[TMP1:%.*]] = load <4 x float>, <4 x float>* bitcast ([16 x float]* @src32 to <4 x float>*), align 4
; CHECK-NEXT:    [[TMP2:%.*]] = call <4 x float> @llvm.sqrt.v4f32(<4 x float> [[TMP1]])
; CHECK-NEXT:    store <4 x float> [[TMP2]], <4 x float>* bitcast ([16 x float]* @dst32 to <4 x float>*), align 4
; CHECK-NEXT:    ret void
;
  %a0 = load float, float* getelementptr inbounds ([16 x float], [16 x float]* @src32, i32 0, i64 0), align 4
  %a1 = load float, float* getelementptr inbounds ([16 x float], [16 x float]* @src32, i32 0, i64 1), align 4
  %a2 = load float, float* getelementptr inbounds ([16 x float], [16 x float]* @src32, i32 0, i64 2), align 4
  %a3 = load float, float* getelementptr inbounds ([16 x float], [16 x float]* @src32, i32 0, i64 3), align 4
  %sqrt0 = call float @llvm.sqrt.f32(float %a0)
  %sqrt1 = call float @llvm.sqrt.f32(float %a1)
  %sqrt2 = call float @llvm.sqrt.f32(float %a2)
  %sqrt3 = call float @llvm.sqrt.f32(float %a3)
  store float %sqrt0, float* getelementptr inbounds ([16 x float], [16 x float]* @dst32, i32 0, i64 0), align 4
  store float %sqrt1, float* getelementptr inbounds ([16 x float], [16 x float]* @dst32, i32 0, i64 1), align 4
  store float %sqrt2, float* getelementptr inbounds ([16 x float], [16 x float]* @dst32, i32 0, i64 2), align 4
  store float %sqrt3, float* getelementptr inbounds ([16 x float], [16 x float]* @dst32, i32 0, i64 3), align 4
  ret void
}

define void @sqrt_8f32() #0 {
; SSE-LABEL: @sqrt_8f32(
; SSE-NEXT:    [[TMP1:%.*]] = load <4 x float>, <4 x float>* bitcast ([16 x float]* @src32 to <4 x float>*), align 4
; SSE-NEXT:    [[TMP2:%.*]] = load <4 x float>, <4 x float>* bitcast (float* getelementptr inbounds ([16 x float], [16 x float]* @src32, i32 0, i64 4) to <4 x float>*), align 4
; SSE-NEXT:    [[TMP3:%.*]] = call <4 x float> @llvm.sqrt.v4f32(<4 x float> [[TMP1]])
; SSE-NEXT:    [[TMP4:%.*]] = call <4 x float> @llvm.sqrt.v4f32(<4 x float> [[TMP2]])
; SSE-NEXT:    store <4 x float> [[TMP3]], <4 x float>* bitcast ([16 x float]* @dst32 to <4 x float>*), align 4
; SSE-NEXT:    store <4 x float> [[TMP4]], <4 x float>* bitcast (float* getelementptr inbounds ([16 x float], [16 x float]* @dst32, i32 0, i64 4) to <4 x float>*), align 4
; SSE-NEXT:    ret void
;
; AVX-LABEL: @sqrt_8f32(
; AVX-NEXT:    [[TMP1:%.*]] = load <8 x float>, <8 x float>* bitcast ([16 x float]* @src32 to <8 x float>*), align 4
; AVX-NEXT:    [[TMP2:%.*]] = call <8 x float> @llvm.sqrt.v8f32(<8 x float> [[TMP1]])
; AVX-NEXT:    store <8 x float> [[TMP2]], <8 x float>* bitcast ([16 x float]* @dst32 to <8 x float>*), align 4
; AVX-NEXT:    ret void
;
  %a0 = load float, float* getelementptr inbounds ([16 x float], [16 x float]* @src32, i32 0, i64 0), align 4
  %a1 = load float, float* getelementptr inbounds ([16 x float], [16 x float]* @src32, i32 0, i64 1), align 4
  %a2 = load float, float* getelementptr inbounds ([16 x float], [16 x float]* @src32, i32 0, i64 2), align 4
  %a3 = load float, float* getelementptr inbounds ([16 x float], [16 x float]* @src32, i32 0, i64 3), align 4
  %a4 = load float, float* getelementptr inbounds ([16 x float], [16 x float]* @src32, i32 0, i64 4), align 4
  %a5 = load float, float* getelementptr inbounds ([16 x float], [16 x float]* @src32, i32 0, i64 5), align 4
  %a6 = load float, float* getelementptr inbounds ([16 x float], [16 x float]* @src32, i32 0, i64 6), align 4
  %a7 = load float, float* getelementptr inbounds ([16 x float], [16 x float]* @src32, i32 0, i64 7), align 4
  %sqrt0 = call float @llvm.sqrt.f32(float %a0)
  %sqrt1 = call float @llvm.sqrt.f32(float %a1)
  %sqrt2 = call float @llvm.sqrt.f32(float %a2)
  %sqrt3 = call float @llvm.sqrt.f32(float %a3)
  %sqrt4 = call float @llvm.sqrt.f32(float %a4)
  %sqrt5 = call float @llvm.sqrt.f32(float %a5)
  %sqrt6 = call float @llvm.sqrt.f32(float %a6)
  %sqrt7 = call float @llvm.sqrt.f32(float %a7)
  store float %sqrt0, float* getelementptr inbounds ([16 x float], [16 x float]* @dst32, i32 0, i64 0), align 4
  store float %sqrt1, float* getelementptr inbounds ([16 x float], [16 x float]* @dst32, i32 0, i64 1), align 4
  store float %sqrt2, float* getelementptr inbounds ([16 x float], [16 x float]* @dst32, i32 0, i64 2), align 4
  store float %sqrt3, float* getelementptr inbounds ([16 x float], [16 x float]* @dst32, i32 0, i64 3), align 4
  store float %sqrt4, float* getelementptr inbounds ([16 x float], [16 x float]* @dst32, i32 0, i64 4), align 4
  store float %sqrt5, float* getelementptr inbounds ([16 x float], [16 x float]* @dst32, i32 0, i64 5), align 4
  store float %sqrt6, float* getelementptr inbounds ([16 x float], [16 x float]* @dst32, i32 0, i64 6), align 4
  store float %sqrt7, float* getelementptr inbounds ([16 x float], [16 x float]* @dst32, i32 0, i64 7), align 4
  ret void
}

define void @sqrt_16f32() #0 {
; SSE-LABEL: @sqrt_16f32(
; SSE-NEXT:    [[TMP1:%.*]] = load <4 x float>, <4 x float>* bitcast ([16 x float]* @src32 to <4 x float>*), align 4
; SSE-NEXT:    [[TMP2:%.*]] = load <4 x float>, <4 x float>* bitcast (float* getelementptr inbounds ([16 x float], [16 x float]* @src32, i32 0, i64 4) to <4 x float>*), align 4
; SSE-NEXT:    [[TMP3:%.*]] = load <4 x float>, <4 x float>* bitcast (float* getelementptr inbounds ([16 x float], [16 x float]* @src32, i32 0, i64 8) to <4 x float>*), align 4
; SSE-NEXT:    [[TMP4:%.*]] = load <4 x float>, <4 x float>* bitcast (float* getelementptr inbounds ([16 x float], [16 x float]* @src32, i32 0, i64 12) to <4 x float>*), align 4
; SSE-NEXT:    [[TMP5:%.*]] = call <4 x float> @llvm.sqrt.v4f32(<4 x float> [[TMP1]])
; SSE-NEXT:    [[TMP6:%.*]] = call <4 x float> @llvm.sqrt.v4f32(<4 x float> [[TMP2]])
; SSE-NEXT:    [[TMP7:%.*]] = call <4 x float> @llvm.sqrt.v4f32(<4 x float> [[TMP3]])
; SSE-NEXT:    [[TMP8:%.*]] = call <4 x float> @llvm.sqrt.v4f32(<4 x float> [[TMP4]])
; SSE-NEXT:    store <4 x float> [[TMP5]], <4 x float>* bitcast ([16 x float]* @dst32 to <4 x float>*), align 4
; SSE-NEXT:    store <4 x float> [[TMP6]], <4 x float>* bitcast (float* getelementptr inbounds ([16 x float], [16 x float]* @dst32, i32 0, i64 4) to <4 x float>*), align 4
; SSE-NEXT:    store <4 x float> [[TMP7]], <4 x float>* bitcast (float* getelementptr inbounds ([16 x float], [16 x float]* @dst32, i32 0, i64 8) to <4 x float>*), align 4
; SSE-NEXT:    store <4 x float> [[TMP8]], <4 x float>* bitcast (float* getelementptr inbounds ([16 x float], [16 x float]* @dst32, i32 0, i64 12) to <4 x float>*), align 4
; SSE-NEXT:    ret void
;
; AVX256-LABEL: @sqrt_16f32(
; AVX256-NEXT:    [[TMP1:%.*]] = load <8 x float>, <8 x float>* bitcast ([16 x float]* @src32 to <8 x float>*), align 4
; AVX256-NEXT:    [[TMP2:%.*]] = load <8 x float>, <8 x float>* bitcast (float* getelementptr inbounds ([16 x float], [16 x float]* @src32, i32 0, i64 8) to <8 x float>*), align 4
; AVX256-NEXT:    [[TMP3:%.*]] = call <8 x float> @llvm.sqrt.v8f32(<8 x float> [[TMP1]])
; AVX256-NEXT:    [[TMP4:%.*]] = call <8 x float> @llvm.sqrt.v8f32(<8 x float> [[TMP2]])
; AVX256-NEXT:    store <8 x float> [[TMP3]], <8 x float>* bitcast ([16 x float]* @dst32 to <8 x float>*), align 4
; AVX256-NEXT:    store <8 x float> [[TMP4]], <8 x float>* bitcast (float* getelementptr inbounds ([16 x float], [16 x float]* @dst32, i32 0, i64 8) to <8 x float>*), align 4
; AVX256-NEXT:    ret void
;
; AVX512-LABEL: @sqrt_16f32(
; AVX512-NEXT:    [[TMP1:%.*]] = load <16 x float>, <16 x float>* bitcast ([16 x float]* @src32 to <16 x float>*), align 4
; AVX512-NEXT:    [[TMP2:%.*]] = call <16 x float> @llvm.sqrt.v16f32(<16 x float> [[TMP1]])
; AVX512-NEXT:    store <16 x float> [[TMP2]], <16 x float>* bitcast ([16 x float]* @dst32 to <16 x float>*), align 4
; AVX512-NEXT:    ret void
;
  %a0  = load float, float* getelementptr inbounds ([16 x float], [16 x float]* @src32, i32 0, i64  0), align 4
  %a1  = load float, float* getelementptr inbounds ([16 x float], [16 x float]* @src32, i32 0, i64  1), align 4
  %a2  = load float, float* getelementptr inbounds ([16 x float], [16 x float]* @src32, i32 0, i64  2), align 4
  %a3  = load float, float* getelementptr inbounds ([16 x float], [16 x float]* @src32, i32 0, i64  3), align 4
  %a4  = load float, float* getelementptr inbounds ([16 x float], [16 x float]* @src32, i32 0, i64  4), align 4
  %a5  = load float, float* getelementptr inbounds ([16 x float], [16 x float]* @src32, i32 0, i64  5), align 4
  %a6  = load float, float* getelementptr inbounds ([16 x float], [16 x float]* @src32, i32 0, i64  6), align 4
  %a7  = load float, float* getelementptr inbounds ([16 x float], [16 x float]* @src32, i32 0, i64  7), align 4
  %a8  = load float, float* getelementptr inbounds ([16 x float], [16 x float]* @src32, i32 0, i64  8), align 4
  %a9  = load float, float* getelementptr inbounds ([16 x float], [16 x float]* @src32, i32 0, i64  9), align 4
  %a10 = load float, float* getelementptr inbounds ([16 x float], [16 x float]* @src32, i32 0, i64 10), align 4
  %a11 = load float, float* getelementptr inbounds ([16 x float], [16 x float]* @src32, i32 0, i64 11), align 4
  %a12 = load float, float* getelementptr inbounds ([16 x float], [16 x float]* @src32, i32 0, i64 12), align 4
  %a13 = load float, float* getelementptr inbounds ([16 x float], [16 x float]* @src32, i32 0, i64 13), align 4
  %a14 = load float, float* getelementptr inbounds ([16 x float], [16 x float]* @src32, i32 0, i64 14), align 4
  %a15 = load float, float* getelementptr inbounds ([16 x float], [16 x float]* @src32, i32 0, i64 15), align 4
  %sqrt0  = call float @llvm.sqrt.f32(float %a0 )
  %sqrt1  = call float @llvm.sqrt.f32(float %a1 )
  %sqrt2  = call float @llvm.sqrt.f32(float %a2 )
  %sqrt3  = call float @llvm.sqrt.f32(float %a3 )
  %sqrt4  = call float @llvm.sqrt.f32(float %a4 )
  %sqrt5  = call float @llvm.sqrt.f32(float %a5 )
  %sqrt6  = call float @llvm.sqrt.f32(float %a6 )
  %sqrt7  = call float @llvm.sqrt.f32(float %a7 )
  %sqrt8  = call float @llvm.sqrt.f32(float %a8 )
  %sqrt9  = call float @llvm.sqrt.f32(float %a9 )
  %sqrt10 = call float @llvm.sqrt.f32(float %a10)
  %sqrt11 = call float @llvm.sqrt.f32(float %a11)
  %sqrt12 = call float @llvm.sqrt.f32(float %a12)
  %sqrt13 = call float @llvm.sqrt.f32(float %a13)
  %sqrt14 = call float @llvm.sqrt.f32(float %a14)
  %sqrt15 = call float @llvm.sqrt.f32(float %a15)
  store float %sqrt0 , float* getelementptr inbounds ([16 x float], [16 x float]* @dst32, i32 0, i64  0), align 4
  store float %sqrt1 , float* getelementptr inbounds ([16 x float], [16 x float]* @dst32, i32 0, i64  1), align 4
  store float %sqrt2 , float* getelementptr inbounds ([16 x float], [16 x float]* @dst32, i32 0, i64  2), align 4
  store float %sqrt3 , float* getelementptr inbounds ([16 x float], [16 x float]* @dst32, i32 0, i64  3), align 4
  store float %sqrt4 , float* getelementptr inbounds ([16 x float], [16 x float]* @dst32, i32 0, i64  4), align 4
  store float %sqrt5 , float* getelementptr inbounds ([16 x float], [16 x float]* @dst32, i32 0, i64  5), align 4
  store float %sqrt6 , float* getelementptr inbounds ([16 x float], [16 x float]* @dst32, i32 0, i64  6), align 4
  store float %sqrt7 , float* getelementptr inbounds ([16 x float], [16 x float]* @dst32, i32 0, i64  7), align 4
  store float %sqrt8 , float* getelementptr inbounds ([16 x float], [16 x float]* @dst32, i32 0, i64  8), align 4
  store float %sqrt9 , float* getelementptr inbounds ([16 x float], [16 x float]* @dst32, i32 0, i64  9), align 4
  store float %sqrt10, float* getelementptr inbounds ([16 x float], [16 x float]* @dst32, i32 0, i64 10), align 4
  store float %sqrt11, float* getelementptr inbounds ([16 x float], [16 x float]* @dst32, i32 0, i64 11), align 4
  store float %sqrt12, float* getelementptr inbounds ([16 x float], [16 x float]* @dst32, i32 0, i64 12), align 4
  store float %sqrt13, float* getelementptr inbounds ([16 x float], [16 x float]* @dst32, i32 0, i64 13), align 4
  store float %sqrt14, float* getelementptr inbounds ([16 x float], [16 x float]* @dst32, i32 0, i64 14), align 4
  store float %sqrt15, float* getelementptr inbounds ([16 x float], [16 x float]* @dst32, i32 0, i64 15), align 4
  ret void
}

attributes #0 = { nounwind }
