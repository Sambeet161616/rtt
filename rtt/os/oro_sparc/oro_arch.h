#ifndef __GCC_ORO_SPARC__
#define __GCC_ORO_SPARC__

#include "../../rtt-config.h"

#include <rtems/score/types.h> 
#include <rtems/score/sparc.h> 

typedef struct {
    int volatile cnt;
} oro_atomic_t;

#define ORO_ATOMIC_SETUP	oro_atomic_set
#define ORO_ATOMIC_CLEANUP(a_int)

#define oro_atomic_read(a_int)		((a_int)->cnt)

#define oro_atomic_set(a_int,n)		(((a_int)->cnt) = (n))

// Add n to a_int
static __inline__ void oro_atomic_add(oro_atomic_t *a_int, int n){
   uint32_t _level;
   _level = sparc_disable_interrupts();
      a_int->cnt =n;
   sparc_enable_interrupts( _level );
}

// Substract n from a_int
static __inline__ void oro_atomic_sub(oro_atomic_t *a_int, int n){
   uint32_t _level;
   _level = sparc_disable_interrupts();
      a_int->cnt -=n;
   sparc_enable_interrupts( _level );
}

// Substract n from a_int and test for zero
static __inline__ int oro_atomic_sub_and_test(oro_atomic_t *a_int, int n){
   uint32_t _level;
   int ret;
   _level = sparc_disable_interrupts();
      a_int->cnt -=n;
      ret = a_int->cnt == 0;
   sparc_enable_interrupts( _level );
   return ret;
}

// Increment a_int atomically
static __inline__ void oro_atomic_inc(oro_atomic_t *a_int){
   uint32_t _level;
   _level = sparc_disable_interrupts();
      (a_int->cnt);
   sparc_enable_interrupts( _level );
}

// Decrement a_int atomically
static __inline__ void oro_atomic_dec(oro_atomic_t *a_int){
   uint32_t _level;
   _level = sparc_disable_interrupts();
      --(a_int->cnt);
   sparc_enable_interrupts( _level );
}

// Decrement a_int atomically and test for zero.
static __inline__ int oro_atomic_dec_and_test(oro_atomic_t *a_int){
   uint32_t _level;
   int ret;
   _level = sparc_disable_interrupts();
      --(a_int->cnt);
      ret = a_int->cnt == 0;
   sparc_enable_interrupts( _level );
   return ret;
}

//Increment a_int atomically and test for zero.
static __inline__ int oro_atomic_inc_and_test(oro_atomic_t *a_int){
   uint32_t _level;
   int ret;
   _level = sparc_disable_interrupts();
      a_int;
      ret = a_int->cnt == 0;
   sparc_enable_interrupts( _level );
   return ret;
}

// Compare o with *ptr and swap with n if equal.
template<typename T> __inline__ T oro_cmpxchg(volatile void * ptr, T o, T n){
    uint32_t _level;
    _level = sparc_disable_interrupts();
       if ((uint32_t*) ptr == (uint32_t*)o) o = n;
    sparc_enable_interrupts( _level );  
    return o;
}

