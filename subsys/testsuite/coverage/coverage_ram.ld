/*
 * Copyright (c) 2019 Intel Corporation
 *
 * SPDX-License-Identifier: Apache-2.0
 */

/* Copied from linker.ld */

#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
SECTION_DATA_PROLOGUE(_GCOV_BSS_SECTION_NAME,(NOLOAD),)
{
#ifdef CONFIG_USERSPACE
	MPU_ALIGN(__gcov_bss_end - __gcov_bss_start );
#else  /* CONFIG_MPU_REQUIRES_POWER_OF_TWO_ALIGNMENT && CONFIG_USERSPACE */
	. = ALIGN(_region_min_align);
#endif /* CONFIG_USERSPACE */

	__gcov_bss_start = .;
	KEEP(*(".bss.__gcov0.*"));

#ifdef CONFIG_USERSPACE
	MPU_ALIGN(__gcov_bss_end - __gcov_bss_start );
#else  /* CONFIG_USERSPACE */
	. = ALIGN(_region_min_align);
#endif /* CONFIG_USERSPACE */

	__gcov_bss_end = .;
} GROUP_NOLOAD_LINK_IN(RAMABLE_REGION, ROMABLE_REGION)
#endif

#ifdef CONFIG_X86_64
SECTION_PROLOGUE(_GCOV_BSS_SECTION_NAME, (NOLOAD), ALIGN(16))
{
	MMU_PAGE_ALIGN
	__gcov_bss_start = .;
	*(".bss.__gcov0.*");
	. = ALIGN(8);
	MMU_PAGE_ALIGN
	__gcov_bss_end = .;
}GROUP_DATA_LINK_IN(RAMABLE_REGION, RAMABLE_REGION)

#elif CONFIG_X86
SECTION_PROLOGUE(_GCOV_BSS_SECTION_NAME, (NOLOAD),)
{
	MMU_PAGE_ALIGN
	__gcov_bss_start = .;
	*(".bss.__gcov0.*");
	. = ALIGN(4);
	MMU_PAGE_ALIGN
	__gcov_bss_end = .;
} GROUP_NOLOAD_LINK_IN(RAMABLE_REGION, ROMABLE_REGION)
#endif

#ifdef CONFIG_ARC
SECTION_PROLOGUE(_GCOV_BSS_SECTION_NAME, (NOLOAD),)
{
	MPU_MIN_SIZE_ALIGN
	__gcov_bss_start = .;
	*(".bss.__gcov0.*");
#ifdef CONFIG_USERSPACE
	. = ALIGN(1 << LOG2CEIL(. - __gcov_bss_start));
#else
	MPU_MIN_SIZE_ALIGN
#endif
	__gcov_bss_end = .;
} GROUP_NOLOAD_LINK_IN(RAMABLE_REGION, ROMABLE_REGION)
#endif

#ifdef CONFIG_RISCV
SECTION_PROLOGUE(_GCOV_BSS_SECTION_NAME, (NOLOAD),)
{
	MPU_MIN_SIZE_ALIGN
	__gcov_bss_start = .;
	*(".bss.__gcov0.*");
	. = ALIGN(4);
	MPU_MIN_SIZE_ALIGN
	__gcov_bss_end = .;
} GROUP_NOLOAD_LINK_IN(RAMABLE_REGION, ROMABLE_REGION)
#endif

__gcov_bss_num_words = ((__gcov_bss_end - __gcov_bss_start) >> 2);
__gcov_bss_size = __gcov_bss_end - __gcov_bss_start;
