/* -*- C++ -*-
   GSStreamContext - Drawing context using the XR Library.

   Copyright (C) 1995 Free Software Foundation, Inc.

   Written by:  Adam Fedor <fedor@boulder.colorado.edu>
   Date: Nov 1995
   
   This file is part of the GNU Objective C User Interface Library.

   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Library General Public
   License as published by the Free Software Foundation; either
   version 2 of the License, or (at your option) any later version.
   
   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.
   
   You should have received a copy of the GNU Library General Public
   License along with this library; if not, write to the Free
   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111 USA.
   */

#include "config.h"
#include "gsc/GSContext.h"
#include "gsc/GSStreamContext.h"
#include <Foundation/NSArray.h>
#include <Foundation/NSData.h>
#include <Foundation/NSDebug.h>
#include <Foundation/NSDictionary.h>
#include <Foundation/NSString.h>
#include <Foundation/NSUserDefaults.h>
#include <Foundation/NSValue.h>
#include <string.h>


@interface GSStreamContext (Private)

- (void) output: (const char*)s;

@end

@implementation GSStreamContext 

- (void) destroyContext;
{
  if (gstream)
    fclose(gstream);
  [super destroyContext];
}

- initWithContextInfo: (NSDictionary *)info
{
  if (info && [info objectForKey: @"NSOutputFile"])
    {
      NSString *path = [info objectForKey: @"NSOutputFile"];
      gstream = fopen([path fileSystemRepresentation], "w");
      if (!gstream)
        {
	  NSDebugLLog(@"GSContext", @"%@: Could not open printer file %@",
		      DPSinvalidfileaccess, path);
	  return nil;
	}
    }
  else
    {
      NSDebugLLog(@"GSContext", @"%@: No stream file specified",
		  DPSconfigurationerror);
      return nil;
    }

  [super initWithContextInfo: info];
  return self;
}

- (BOOL)isDrawingToScreen
{
  return NO;
}

- (GSGState *) currentGState
{
  return nil;
}

@end

@implementation GSStreamContext (Ops)
/* ----------------------------------------------------------------------- */
/* Color operations */
/* ----------------------------------------------------------------------- */
- (void) DPScurrentalpha: (float*) a
{
  NSLog(@"DPSinvalidcontext: getting values from stream context");
}

- (void) DPScurrentcmykcolor: (float*) c: (float*) m: (float*) y: (float*) k
{
  NSLog(@"DPSinvalidcontext: getting values from stream context");
}

- (void) DPScurrentgray: (float*) gray
{
  NSLog(@"DPSinvalidcontext: getting values from stream context");
}

- (void) DPScurrenthsbcolor: (float*) h: (float*) s: (float*) b
{
  NSLog(@"DPSinvalidcontext: getting values from stream context");
}

- (void) DPScurrentrgbcolor: (float*) r: (float*) g: (float*) b
{
  NSLog(@"DPSinvalidcontext: getting values from stream context");
}

- (void) DPSsetalpha: (float) a
{
  fprintf(gstream, "%g setalpha\n", a);
}

- (void) DPSsetcmykcolor: (float) c: (float) m: (float) y: (float) k
{
  fprintf(gstream, "%g %g %g %g setcmykcolor\n", c, m, y, k);
}

- (void) DPSsetgray: (float) gray
{
  fprintf(gstream, "%g setgray\n", gray);
}

- (void) DPSsethsbcolor: (float) h: (float) s: (float) b
{
  fprintf(gstream, "%g %g %g sethsbcolor\n", h, s, b);
}

- (void) DPSsetrgbcolor: (float) r: (float) g: (float) b
{
  fprintf(gstream, "%g %g %g setrgbcolor\n", r, g, b);
}


- (void) GSSetFillColorspace: (NSDictionary *) dict
{
  [self notImplemented: _cmd];
}

- (void) GSSetStrokeColorspace: (NSDictionary *) dict
{
  [self notImplemented: _cmd];
}

- (void) GSSetFillColor: (float *) values
{
  [self notImplemented: _cmd];
}

- (void) GSSetStrokeColor: (float *) values
{
  [self notImplemented: _cmd];
}


/* ----------------------------------------------------------------------- */
/* Text operations */
/* ----------------------------------------------------------------------- */
- (void) DPSashow: (float) x: (float) y: (const char*) s
{
  fprintf(gstream, "%g %g %s ashow\n", x, y, s);
}

- (void) DPSawidthshow: (float) cx: (float) cy: (int) c: (float) ax: (float) ay: (const char*) s
{
  fprintf(gstream, "%g %g %d %g %g %s awidthshow\n", cx, cy, c, ax, ay, s);
}

- (void) DPScharpath: (const char*) s: (int) b
{
  fprintf(gstream, "%s %d charpath\n", s, b);
}

- (void) DPSshow: (const char*) s
{
  fprintf(gstream, "%s show\n", s);
}

- (void) DPSwidthshow: (float) x: (float) y: (int) c: (const char*) s
{
  fprintf(gstream, "%g %g %d %s widthshow\n", x, y, c, s);
}

- (void) DPSxshow: (const char*) s: (const float*) numarray: (int) size
{
}

- (void) DPSxyshow: (const char*) s: (const float*) numarray: (int) size
{
}

- (void) DPSyshow: (const char*) s: (const float*) numarray: (int) size
{
}


- (void) GSSetCharacterSpacing: (float) extra
{
  [self notImplemented: _cmd];
}

- (void) GSSetFont: (NSFont*) font
{
  [self notImplemented: _cmd];
}

- (void) GSSetFontSize: (float) size
{
  [self notImplemented: _cmd];
}

- (NSAffineTransform *) GSGetTextCTM
{
  NSLog(@"DPSinvalidcontext: getting values from stream context");
  return nil;
}

- (NSPoint) GSGetTextPosition
{
  NSLog(@"DPSinvalidcontext: getting values from stream context");
  return NSMakePoint(0,0);
}

- (void) GSSetTextCTM: (NSAffineTransform *) ctm
{
  [self notImplemented: _cmd];
}

- (void) GSSetTextDrawingMode: (GSTextDrawingMode) mode
{
  [self notImplemented: _cmd];
}

- (void) GSSetTextPosition: (NSPoint) loc
{
  [self notImplemented: _cmd];
}

- (void) GSShowText: (const char *) string: (size_t) length
{
  [self notImplemented: _cmd];
}

- (void) GSShowGlyphs: (const NSGlyph *) glyphs: (size_t) length
{
  [self notImplemented: _cmd];
}


/* ----------------------------------------------------------------------- */
/* Gstate Handling */
/* ----------------------------------------------------------------------- */
- (void) DPScurrentgstate: (int) gst
{
  NSLog(@"DPSinvalidcontext: getting values from stream context");
}

- (void) DPSgrestore
{
  fprintf(gstream, "grestore\n");
}

- (void) DPSgsave
{
  fprintf(gstream, "gsave\n");
}

- (void) DPSgstate
{
}

- (void) DPSinitgraphics
{
  fprintf(gstream, "initgraphics\n");
}

- (void) DPSsetgstate: (int) gst
{
}


- (int) GSDefineGState
{
  NSLog(@"DPSinvalidcontext: getting values from stream context");
  return 0;
}

- (void) GSUndefineGState: (int) gst
{
  [self notImplemented: _cmd];
}

- (void) GSReplaceGState: (int) gst
{
  [self notImplemented: _cmd];
}

- (void) GSCreateGState: (int) gst
{
  [self notImplemented: _cmd];
}

- (void) GSSetGState: (int) gst
{
  [self notImplemented: _cmd];
}


/* ----------------------------------------------------------------------- */
/* Gstate operations */
/* ----------------------------------------------------------------------- */
- (void) DPScurrentflat: (float*) flatness
{
  NSLog(@"DPSinvalidcontext: getting values from stream context");
}

- (void) DPScurrentlinecap: (int*) linecap
{
  NSLog(@"DPSinvalidcontext: getting values from stream context");
}

- (void) DPScurrentlinejoin: (int*) linejoin
{
  NSLog(@"DPSinvalidcontext: getting values from stream context");
}

- (void) DPScurrentlinewidth: (float*) width
{
  NSLog(@"DPSinvalidcontext: getting values from stream context");
}

- (void) DPScurrentmiterlimit: (float*) limit
{
  NSLog(@"DPSinvalidcontext: getting values from stream context");
}

- (void) DPScurrentpoint: (float*) x: (float*) y
{
  NSLog(@"DPSinvalidcontext: getting values from stream context");
}

- (void) DPScurrentstrokeadjust: (int*) b
{
  NSLog(@"DPSinvalidcontext: getting values from stream context");
}

- (void) DPSsetdash: (const float*) pat: (int) size: (float) offset
{
  int i;
  fprintf(gstream, "[");
  for (i = 0; i < size; i++)
    fprintf(gstream, "%f ", pat[i]);
  fprintf(gstream, "] %g setdash\n", offset);
}

- (void) DPSsetflat: (float) flatness
{
  fprintf(gstream, "%g setflat\n", flatness);
}

- (void) DPSsethalftonephase: (float) x: (float) y
{
  fprintf(gstream, "%g %g sethalftonephase\n", x, y);
}

- (void) DPSsetlinecap: (int) linecap
{
  fprintf(gstream, "%d setlinecap\n", linecap);
}

- (void) DPSsetlinejoin: (int) linejoin
{
  fprintf(gstream, "%d setlinejoin\n", linejoin);
}

- (void) DPSsetlinewidth: (float) width
{
  fprintf(gstream, "%g setlinewidth\n", width);
}

- (void) DPSsetmiterlimit: (float) limit
{
  fprintf(gstream, "%g setmiterlimit\n", limit);
}

- (void) DPSsetstrokeadjust: (int) b
{
  fprintf(gstream, "%d setstrokeadjust\n", b);
}


/* ----------------------------------------------------------------------- */
/* Matrix operations */
/* ----------------------------------------------------------------------- */
- (void) DPSconcat: (const float*) m
{
  fprintf(gstream, "[%g %g %g %g %g %g] concat\n",
          m[0], m[1], m[2], m[3], m[4], m[5]);
}

- (void) DPSinitmatrix
{
  fprintf(gstream, "initmatrix\n");
}

- (void) DPSrotate: (float) angle
{
  fprintf(gstream, "%g rotate\n", angle);
}

- (void) DPSscale: (float) x: (float) y
{
  fprintf(gstream, "%g %g scale\n", x, y);
}

- (void) DPStranslate: (float) x: (float) y
{
  fprintf(gstream, "%g %g translate\n", x, y);
}


- (NSAffineTransform *) GSCurrentCTM
{
  NSLog(@"DPSinvalidcontext: getting values from stream context");
  return nil;
}

- (void) GSSetCTM: (NSAffineTransform *) ctm
{
  [self notImplemented: _cmd];
}

- (void) GSConcatCTM: (NSAffineTransform *) ctm
{
  [self notImplemented: _cmd];
}


/* ----------------------------------------------------------------------- */
/* Paint operations */
/* ----------------------------------------------------------------------- */
- (void) DPSarc: (float) x: (float) y: (float) r: (float) angle1: (float) angle2
{
  fprintf(gstream, "%g %g %g %g %g arc\n", x, y, r, angle1, angle2);
}

- (void) DPSarcn: (float) x: (float) y: (float) r: (float) angle1: (float) angle2
{
  fprintf(gstream, "%g %g %g %g %g arcn\n", x, y, r, angle1, angle2);
}

- (void) DPSarct: (float) x1: (float) y1: (float) x2: (float) y2: (float) r
{
  fprintf(gstream, "%g %g %g %g %g arct\n", x1, y1, x2, y2, r);
}

- (void) DPSclip
{
  fprintf(gstream, "clip\n");
}

- (void) DPSclosepath
{
  fprintf(gstream, "closepath\n");
}

- (void) DPScurveto: (float) x1: (float) y1: (float) x2: (float) y2: (float) x3: (float) y3
{
  fprintf(gstream, "%g %g %g %g %g %g curveto\n", x1, y1, x2, y2, x3, y3);
}

- (void) DPSeoclip
{
  fprintf(gstream, "eoclip\n");
}

- (void) DPSeofill
{
  fprintf(gstream, "eofill\n");
}

- (void) DPSfill
{
  fprintf(gstream, "fill\n");
}

- (void) DPSflattenpath
{
  fprintf(gstream, "flattenpath\n");
}

- (void) DPSinitclip
{
  fprintf(gstream, "initclip\n");
}

- (void) DPSlineto: (float) x: (float) y
{
  fprintf(gstream, "%g %g lineto\n", x, y);
}

- (void) DPSmoveto: (float) x: (float) y
{
  fprintf(gstream, "%g %g moveto\n", x, y);
}

- (void) DPSnewpath
{
  fprintf(gstream, "newpath\n");
}

- (void) DPSpathbbox: (float*) llx: (float*) lly: (float*) urx: (float*) ury
{
}

- (void) DPSrcurveto: (float) x1: (float) y1: (float) x2: (float) y2: (float) x3: (float) y3
{
  fprintf(gstream, "%g %g %g %g %g %g rcurveto\n", x1, y1, x2, y2, x3, y3);
}

- (void) DPSrectclip: (float) x: (float) y: (float) w: (float) h
{
  fprintf(gstream, "%g %g %g %g rectclip\n", x, y, w, h);
}

- (void) DPSrectfill: (float) x: (float) y: (float) w: (float) h
{
  fprintf(gstream, "%g %g %g %g rectfill\n", x, y, w, h);
}

- (void) DPSrectstroke: (float) x: (float) y: (float) w: (float) h
{
  fprintf(gstream, "%g %g %g %g rectstroke\n", x, y, w, h);
}

- (void) DPSreversepath
{
  fprintf(gstream, "reversepath\n");
}

- (void) DPSrlineto: (float) x: (float) y
{
  fprintf(gstream, "%g %g rlineto\n", x, y);
}

- (void) DPSrmoveto: (float) x: (float) y
{
  fprintf(gstream, "%g %g rmoveto\n", x, y);
}

- (void) DPSstroke
{
  fprintf(gstream, "stroke\n");
}


- (void) GSSendBezierPath: (NSBezierPath *) path
{
  [self notImplemented: _cmd];
}

- (void) GSRectClipList: (const NSRect *) rects: (int) count
{
  [self notImplemented: _cmd];
}

- (void) GSRectFillList: (const NSRect *) rects: (int) count
{
  [self notImplemented: _cmd];
}


/* ----------------------------------------------------------------------- */
/* Window system ops */
/* ----------------------------------------------------------------------- */
- (void) DPScurrentgcdrawable: (void**) gc: (void**) draw: (int*) x: (int*) y
{
  NSLog(@"DPSinvalidcontext: getting values from stream context");
}

- (void) DPScurrentoffset: (int*) x: (int*) y
{
  NSLog(@"DPSinvalidcontext: getting values from stream context");
}

- (void) DPSsetgcdrawable: (void*) gc: (void*) draw: (int) x: (int) y
{
}

- (void) DPSsetoffset: (short int) x: (short int) y
{
}


/*-------------------------------------------------------------------------*/
/* Graphics Extensions Ops */
/*-------------------------------------------------------------------------*/
- (void) DPScomposite: (float) x: (float) y: (float) w: (float) h: (int) gstateNum: (float) dx: (float) dy: (int) op
{
  fprintf(gstream, "%g %g %g %g %d %g %g %d composite\n", x, y, w, h, gstateNum, dx, dy, op);
}

- (void) DPScompositerect: (float) x: (float) y: (float) w: (float) h: (int) op
{
  fprintf(gstream, "%g %g %g %g %d compositerect\n", x, y, w, h, op);
}

- (void) DPSdissolve: (float) x: (float) y: (float) w: (float) h: (int) gstateNum: (float) dx: (float) dy: (float) delta
{
  fprintf(gstream, "%g %g %g %g %d %g %g %g dissolve\n", x, y, w, h, gstateNum, dx, dy, delta);
}


- (void) GSDrawImage: (NSRect) rect: (void *) imageref
{
  [self notImplemented: _cmd];
}


/* ----------------------------------------------------------------------- */
/* Client functions */
/* ----------------------------------------------------------------------- */
- (void) DPSPrintf: (char *)fmt : (va_list)args
{
  vfprintf(gstream, fmt, args);
}

- (void) DPSWriteData: (char *)buf : (unsigned int)count
{
  /* Not sure here. Should we translate to ASCII if it's not
     already? */
}

@end

static char *hexdigits = "0123456789abcdef";

void
writeHex(FILE *gstream, const unsigned char *data, int count)
{
  int i;
  for (i = 0; i < count; i++)
    {
      fprintf(gstream, "%c%c", hexdigits[(int)(data[0]/16)],
	      hexdigits[(data[0] % 16)]);
      if (i && i % 40 == 0)
	fprintf(gstream, "\n");
    }
}

@implementation GSStreamContext (Graphics)

- (void) NSDrawBitmap: (NSRect) rect : (int) pixelsWide : (int) pixelsHigh
		     : (int) bitsPerSample : (int) samplesPerPixel 
		     : (int) bitsPerPixel : (int) bytesPerRow : (BOOL) isPlanar
		     : (BOOL) hasAlpha : (NSString *) colorSpaceName
		     : (const unsigned char *const [5]) data
{
  int bytes;
  NSSize scale;

  scale = NSMakeSize(NSWidth(rect) / pixelsWide, 
		     NSHeight(rect) / pixelsHigh);
  /* Save scaling */
  fprintf(gstream, "matrix\ncurrentmatrix\n");
  fprintf(gstream, "%f %f translate %f %f scale\n", 
	  NSMinX(rect), NSMinY(rect), scale.width, scale.height);

  if (bitsPerSample == 0)
    bitsPerSample = 8;
  bytes = 
    (bitsPerSample * pixelsWide * pixelsHigh + 7) / 8;
  if (bytes * samplesPerPixel != bytesPerRow * pixelsHigh) 
    {
      NSLog(@"Image Rendering Error: Dodgy bytesPerRow value %d", bytesPerRow);
      NSLog(@"   pixelsHigh=%d, bytes=%d, samplesPerPixel=%d",
	    bytesPerRow, pixelsHigh, bytes);
      return;
    }

  if(samplesPerPixel > 1) 
    {
      if(isPlanar || hasAlpha) 
	{
	  if(bitsPerSample != 8) 
	    {
	      NSLog(@"Image format conversion not supported for bps!=8");
	      return;
	    }
	}
      fprintf(gstream, "%d %d %d [%d 0 0 -%d 0 %d]\n",
	      pixelsWide, pixelsHigh, bitsPerSample, pixelsWide,
	      pixelsHigh, pixelsHigh);
      fprintf(gstream, "{currentfile %d string readhexstring pop}\n",
	      bytesPerRow);
      fprintf(gstream, "false %d colorimage\n", 
	      hasAlpha?(samplesPerPixel-1):samplesPerPixel);
    } 
  else
    {
      fprintf(gstream, "%d %d %d [%d 0 0 -%d 0 %d]\n",
	      pixelsWide, pixelsHigh, bitsPerSample, pixelsWide,
	      pixelsHigh, pixelsHigh);
      fprintf(gstream, "currentfile image\n");
    }
  
  // The context is now waiting for data on its standard input
  if(isPlanar || hasAlpha) 
    {
      // We need to do a format conversion.
      // We do this on the fly, sending data to the context as soon as
      // it is computed.
      int i, j, spp, alpha;
      unsigned char val;
      if(hasAlpha)
	spp = samplesPerPixel - 1;
      else
	spp = samplesPerPixel;
      
      for(j=0; j<bytes; j++) 
	{
	  if(hasAlpha) 
	    {
	      if(isPlanar)
		alpha = data[spp][j];
	      else
		alpha = data[0][spp+j*samplesPerPixel];
	    }
	  for (i = 0; i < spp; i++) 
	    {
	      if(isPlanar)
		val = data[i][j];
	      else
		val = data[0][i+j*samplesPerPixel];
	      if(hasAlpha)
		val = 255 - ((255-val)*(long)alpha)/255;
	      writeHex(gstream, &val, 1);
	    }
	  if (j && j % 40 == 0)
	    fprintf(gstream, "\n");
	}
      fprintf(gstream, "\n");
    } 
  else 
    {
      // The data is already in the format the context expects it in
      writeHex(gstream, data[0], bytes*samplesPerPixel);
    }

  /* Restore original scaling */
  fprintf(gstream, "setmatrix\n");
}

@end

@implementation GSStreamContext (Private)

- (void) output: (const char*)s
{
  const char *t = s;

  while (*t)
    {
      switch (*t)
      {
	case '(':
	    fputs("\\(", gstream);
	    break;
	case ')':
	    fputs("\\)", gstream);
	    break;
	default:
	    fputc(*t, gstream);
	    break;
      }
      t++;
    }
}

@end
