; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+serialize | FileCheck %s --check-prefix=X86_64
; RUN: llc < %s -mtriple=i386-unknown-unknown -mattr=+serialize | FileCheck %s --check-prefix=X86
; RUN: llc < %s -mtriple=x86_64-linux-gnux32 -mattr=+serialize | FileCheck %s --check-prefix=X32

define void @test_serialize() {
; X86_64-LABEL: test_serialize:
; X86_64:       # %bb.0: # %entry
; X86_64-NEXT:    serialize
; X86_64-NEXT:    retq
;
; X86-LABEL: test_serialize:
; X86:       # %bb.0: # %entry
; X86-NEXT:    serialize
; X86-NEXT:    retl
;
; X32-LABEL: test_serialize:
; X32:       # %bb.0: # %entry
; X32-NEXT:    serialize
; X32-NEXT:    retq
entry:
  call void @llvm.x86.serialize()
  ret void
}

declare void @llvm.x86.serialize()
