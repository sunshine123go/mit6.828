// Simple implementation of cprintf console output for the kernel,
// based on printfmt() and the kernel console's cputchar().

#include <inc/types.h>
#include <inc/stdio.h>
#include <inc/stdarg.h>


static void
putch(int ch, int *cnt)
{
	cputchar(ch);
	(*cnt)++;
}

int
vcprintf(const char *fmt, va_list ap)
{
	int cnt = 0;

	vprintfmt((void*)putch, &cnt, fmt, ap);
	return cnt;
}

int
cprintf(const char *fmt, ...)
{
	va_list ap;
	int cnt;

	va_start(ap, fmt);
	cnt = vcprintf(fmt, ap);
	va_end(ap);

	return cnt;
}

static void
putch_color(int ch, int *color)
{
	ch |= (*color) << 8;
	cputchar(ch);
}

void vcprintf_color(real_color_t back, real_color_t front, const char *fmt, va_list ap)
{
	int color;
	color = (back << 4) | (front & 0xF);
	vprintfmt((void *)putch_color, &color, fmt, ap);
}
void
cprintf_color(real_color_t back, real_color_t front, const char *fmt, ...)
{
	va_list ap;
	va_start(ap, fmt);
	vcprintf_color(back, front, fmt, ap);
	va_end(ap);
}
