//=============================================================================
// sgImages.pas
//=============================================================================
//
// The Images unit contains the code related to manipulating and querying
// bitmap structures.
//
//=============================================================================

/// The Images module contains the code that relates to the manipulating and
/// querying of bitmap structures.
///
/// @module Images
/// @static
unit sgImages;



//=============================================================================
interface
uses sgTypes;
//=============================================================================


//----------------------------------------------------------------------------
// Bitmap loading routines
//----------------------------------------------------------------------------
  
  /// Creates a bitmap in memory that is the specified width and height (in pixels).
  /// The new bitmap is initially transparent and can be used as the target 
  /// for various drawing operations. Once you have drawn the desired image onto
  /// the bitmap you can call OptimiseBitmap to optimise the surface.
  ///
  /// @lib
  /// @sn createBitmapWidth:%s height:%s
  ///
  /// @class Bitmap
  /// @constructor
  /// @csn initWithWidth:%s andHeight:%s
  function CreateBitmap(width, height: Longint): Bitmap; overload;
  
  /// Creates a bitmap in memory that is the specified width and height (in pixels).
  /// The new bitmap is initially transparent and can be used as the target 
  /// for various drawing operations. Once you have drawn the desired image onto
  /// the bitmap you can call OptimiseBitmap to optimise the surface.
  ///
  /// @lib CreateBitmapNamed
  /// @sn createBitmapNamed:%s width:%s height:%s
  ///
  /// @class Bitmap
  /// @constructor
  /// @csn initNamed:%s withWidth:%s andHeight:%s
  function CreateBitmap(name: String; width, height: Longint): Bitmap; overload;
  
  /// Creates a new bitmap by combining together the bitmaps from an array. 
  /// The bitmaps will be arranged in the number of columns specified, the 
  /// number of rows will be determined by the number of columns specified.
  /// This can be used to create a bitmap that can be used by a Sprite for
  /// animation.
  ///
  /// @lib
  /// @sn combineIntoBitmap:%s columns:%s
  function CombineIntoGrid(const bitmaps: BitmapArray; cols: LongInt): Bitmap;
  
  /// Loads a bitmap from file using where the specified transparent color
  /// is used as a color key for the transparent color.
  ///
  /// @lib LoadBitmapWithTransparentColor
  /// @sn loadBitmapFile:%s colorKeyed:%s withColor:%s
  ///
  /// @class Bitmap
  /// @constructor
  /// @csn initWithPath:%s withTransparency:%s usingColor:%s
  function LoadBitmap(filename: String; transparent: Boolean; transparentColor: Color): Bitmap; overload;

  /// Loads a bitmap from file into a Bitmap variable. This can then be drawn to
  /// the screen. Bitmaps can be of bmp, jpeg, gif, png, etc. Images may also
  /// contain alpha values, which will be drawn correctly by the API. All
  /// bitmaps must be freed using the FreeBitmap once you are finished with
  /// them.
  /// 
  /// @lib
  /// @sn loadBitmapFile:%s
  ///
  /// @class Bitmap
  /// @constructor
  /// @csn initWithPath:%s
  function LoadBitmap(filename : String): Bitmap; overload;

  /// Loads a bitmap with a transparent color key. The transparent color is then
  /// setup as the color key to ensure the image is drawn correctly. Alpha
  /// values of Images loaded in this way will be ignored. All bitmaps must be
  /// freed using the `FreeBitmap` once you are finished with them.
  ///
  /// @lib LoadBitmapWithTransparentColor(filename, True, transparentColor)
  /// @sn loadBitmapFile:%s withColorKey:%s
  ///
  /// @class Bitmap
  /// @constructor
  /// @csn initWithPath:%s transparentColor:%s
  function LoadTransparentBitmap(filename : String; transparentColor : Color): Bitmap; overload;

  /// Frees a loaded bitmap. Use this when you will no longer be drawing the
  /// bitmap (including within Sprites), and when the program exits.
  ///
  /// @lib
  ///
  /// @class Bitmap
  /// @dispose
  procedure FreeBitmap(var bitmapToFree : Bitmap);
  
  
  
//----------------------------------------------------------------------------
// Bitmap mapping routines
//----------------------------------------------------------------------------
  
  /// Loads and returns a bitmap. The supplied ``filename`` is used to
  /// locate the Bitmap to load. The supplied ``name`` indicates the 
  /// name to use to refer to this Bitmap in SwinGame. The `Bitmap` can then be
  /// retrieved by passing this ``name`` to the `BitmapNamed` function. 
  ///
  /// @lib
  /// @sn loadBitmapNamed:%s fromFile:%s
  ///
  /// @class Bitmap
  /// @constructor
  /// @csn initWithName:%s fromFile:%s
  function LoadBitmapNamed(name, filename: String): Bitmap;
  
  /// Loads and returns a bitmap with a given color code use for transparency.
  /// The supplied ``filename`` is used to locate the Bitmap to load. The supplied
  /// ``name`` indicates thename to use to refer to this Bitmap in SwinGame. The 
  /// `Bitmap` can then be retrieved by passing this ``name`` to the `BitmapNamed` function. 
  ///
  /// @lib
  /// @sn loadBitmapNamed:%s toFile:%s colorKey:%s
  ///
  /// @class Bitmap
  /// @constructor
  /// @csn initWithName:%s fromFile:%s colorKey:%s
  function LoadTransparentBitmapNamed(name, filename: String; transparentColor: Color): Bitmap;
  
  /// Determines if SwinGame has a bitmap loaded for the supplied name.
  /// This checks against all bitmaps loaded, those loaded without a name
  /// are assigned the filename as a default.
  ///
  /// @lib
  function HasBitmap(name: String): Boolean;
  
  /// Returns the `Bitmap` that has been loaded with the specified name,
  /// see `LoadBitmapNamed`.
  ///
  /// @lib
  function BitmapNamed(name: String): Bitmap;
  
  /// Releases the SwinGame resources associated with the bitmap of the
  /// specified ``name``.
  ///
  /// @lib
  procedure ReleaseBitmap(name: String);
  
  /// Releases all of the bitmaps that have been loaded.
  ///
  /// @lib
  procedure ReleaseAllBitmaps();
  
  
  
//---------------------------------------------------------------------------
// Bitmap querying functions
//---------------------------------------------------------------------------
  
  /// Returns the width of the entire bitmap.
  ///
  /// @lib
  ///
  /// @class Bitmap
  /// @getter Width
  function BitmapWidth(bmp: Bitmap): Longint; overload;
  
  /// Returns the height of the entire bitmap.
  /// 
  /// @lib
  /// 
  /// @class Bitmap
  /// @getter Height
  function BitmapHeight(bmp: Bitmap): Longint; overload;
  
  /// Returns the width of a cell within the bitmap.
  /// 
  /// @lib
  /// 
  /// @class Bitmap
  /// @getter CellWidth
  function BitmapCellWidth(bmp: Bitmap): Longint;
  
  /// Returns the height of a cell within the bitmap.
  ///
  /// @lib
  ///
  /// @class Bitmap
  /// @getter CellHeight
  function BitmapCellHeight(bmp: Bitmap): Longint;

  /// Checks if a pixel is drawn at the specified x,y location.
  /// 
  /// @lib
  /// @sn pixelOf:%s drawnAtX:%s y:%s
  ///
  /// @class Bitmap
  /// @method PixelDrawnAtPoint  
  /// @csn pixelDrawnAtX:%s y:%s
  function PixelDrawnAtPoint(bmp: Bitmap; x, y: Single): Boolean;
  
  /// This is used to define the number of cells in a bitmap, and 
  /// their width and height. The cells are
  /// traversed in rows so that the format would be [0 - 1 - 2] 
  /// [3 - 4 - 5] etc. The count can be used to restrict which of the 
  /// parts of the bitmap actually contain cells that can be drawn.
  ///
  /// @lib
  /// @sn bitmap:%s setCellWidth:%s height:%s columns:%s rows:%s count:%s
  ///
  /// @class Bitmap
  /// @method SetCellDetails
  /// @csn setCellWidth:%s height:%s columns:%s rows:%s count:%s
  procedure BitmapSetCellDetails(bmp: Bitmap; width, height, columns, rows, count: Longint);
  
  /// Returns the number of cells in the specified bitmap.
  ///
  /// @lib
  ///
  /// @class Bitmap
  /// @getter CellCount
  function BitmapCellCount(bmp: Bitmap): Longint;
  
  /// Returns the number of rows of cells in the specified bitmap.
  ///
  /// @lib
  ///
  /// @class Bitmap
  /// @getter CellRows
  function BitmapCellRows(bmp: Bitmap): Longint;
  
  /// Returns the number of columns of cells in the specified bitmap.
  ///
  /// @lib
  ///
  /// @class Bitmap
  /// @getter CellColumns
  function BitmapCellColumns(bmp: Bitmap): Longint;
  
  /// Are the two bitmaps of a similar format that they could be used in
  /// place of each other. This returns true if they have the same cell
  /// details (count, width, and height).
  ///
  /// @lib
  /// @sn bitmap: %s interchangableWith:%s
  ///
  /// @class Bitmap
  /// @method interchangableWith
  function BitmapsInterchangable(bmp1, bmp2: Bitmap): Boolean;
  
  /// Returns the name of the bitmap
  ///
  /// @lib
  ///
  /// @class Bitmap
  /// @getter Name
  function BitmapName(bmp:Bitmap): string;
  
  /// Returns the Filename of the bitmap
  ///
  /// @lib
  ///
  /// @class Bitmap
  /// @getter Filename
  function BitmapFilename(bmp:Bitmap): string;

  
//----------------------------------------------------------------------------
// Bitmap -> Circle
//----------------------------------------------------------------------------
  
  /// Creates a circle from within a bitmap, uses the larger of the width and
  /// height.
  ///
  /// @lib
  /// @sn circleFrombitmap:%s atPt:%s
  /// 
  /// @class Bitmap
  /// @method ToCircle
  /// @csn circleAtPt:%s
  function BitmapCircle(bmp: Bitmap; const pt: Point2D): Circle; overload;
  
  /// Creates a circle from within a bitmap, uses the larger of the width and
  /// height.
  ///
  /// @lib BitmapCircleXY
  /// @sn circleFromBitmap:%s atX:%s y:%s
  /// 
  /// @class Bitmap
  /// @overload ToCircle ToCircleXY
  /// @csn circleAtX:%s y:%s
  function BitmapCircle(bmp: Bitmap; x, y: Single): Circle; overload;
  
  /// Creates a circle from within a cell in a bitmap, uses the larger of the width and
  /// height.
  ///
  /// @lib
  /// @sn circleFromBitmap:%s cellAtPt:%s
  ///
  /// @class Bitmap
  /// @method ToCellCircle
  /// @csn circleCellAtPT:%s 
  function BitmapCellCircle(bmp: Bitmap; const pt: Point2D): Circle; overload;
  
  /// Creates a circle from within a cell in a bitmap, uses the larger of the width and
  /// height.
  ///
  /// @lib BitmapCellCircleXY
  /// @sn circleBitmap:%s cellAtX:%s y:%s
  ///
  /// @class Bitmap
  /// @overload ToCellCircle ToCellCircleXY
  /// @csn circleCellAtX:%s y:%s
  function BitmapCellCircle(bmp: Bitmap; x, y: Single): Circle; overload;
  
  
  
//---------------------------------------------------------------------------
// Alpha blendings adjusting code
//---------------------------------------------------------------------------
  
  /// Removes any surface level transparency from the supplied bitmap.
  ///
  /// @lib
  ///
  /// @class Bitmap
  /// @method MakeOpaque
  procedure MakeOpaque(bmp: Bitmap);
  
  /// Turns on the surface level transparency for the supplied bitmap, 
  /// and set the transparency value to the percentage supplied in pct.
  ///
  /// @lib
  /// @sn setOpacityOf:%s pct:%s
  /// 
  /// @class Bitmap
  /// @method SetOpacity
  procedure SetOpacity(bmp: Bitmap; pct: Single);
  
  /// Turns on the surface level transparency for the supplied bitmap, the
  /// transparency value is then set to 0 (fully transparent).
  ///
  /// @lib
  /// @class Bitmap
  /// @method MakeTransparent
  procedure MakeTransparent(bmp: Bitmap);
  
  
  
//---------------------------------------------------------------------------
// Save
//---------------------------------------------------------------------------
  
  /// Saves the bitmap to a png file at the specified location.
  ///
  /// @lib
  /// @sn bitmap:%s saveToPNG:%s
  ///
  /// @class Bitmap
  /// @method SaveToPNG
  procedure SaveToPNG(bmp: Bitmap; filename: String);
    
  /// Setup the passed in bitmap for pixel level collisions.
  ///
  /// @lib
  /// @class Bitmap
  /// @method SetupForCollisions
  procedure SetupBitmapForCollisions(src: Bitmap);
  
  
//---------------------------------------------------------------------------
// Optimise
//---------------------------------------------------------------------------

  /// Created bitmaps can be optimised for faster drawing to the screen. This
  /// optimisation should be called only once after all drawing to the bitmap
  /// is complete. Optimisation should not be used if the bitmap is to be
  /// drawn onto in the future. All loaded bitmaps are optimised during loading.
  ///
  /// @lib
  ///
  /// @class Bitmap
  /// @method OptimiseBitmap
  procedure OptimiseBitmap(surface: Bitmap);
  
  
  
//---------------------------------------------------------------------------
// Bitmap drawing routines - clearing
//---------------------------------------------------------------------------
  
  /// Clear the drawing on the Bitmap to the passed in color.
  ///
  /// @lib
  /// @sn clearSurface:%s color:%s
  ///
  /// @class Bitmap
  /// @overload ClearSurface ClearSurfaceToColor
  /// @csn clearSurfaceTo:%s
  procedure ClearSurface(dest: Bitmap; toColor: Color); overload;
  
  /// Clears the drawing on the Bitmap to black.
  ///
  /// @lib ClearSurfaceToBlack
  ///
  /// @class Bitmap
  /// @method ClearSurface
  procedure ClearSurface(dest: Bitmap); overload;
  
  
  
//---------------------------------------------------------------------------
// Bitmap -> Rectangle functions
//---------------------------------------------------------------------------
  
  /// Returns a bounding rectangle for the bitmap.
  /// 
  /// @lib BitmapRectXY
  /// @sn rectangleAtX:%s y:%s forBitmap:%s
  ///
  /// @class Bitmap
  /// @overload ToRectangle ToRectangleAtXY
  /// @self 3
  /// @csn toRectangleAtX:%s y:%s
  function BitmapRectangle(x, y: Single; bmp: Bitmap): Rectangle; overload;
  
  /// Returns a bounding rectangle for the bitmap, at the origin.
  /// 
  /// @lib BitmapRectAtOrigin
  ///
  /// @class Bitmap
  /// @overload ToRectangle ToRectangleAtOrigin
  /// @csn toRectangleAtOrigin
  function BitmapRectangle(bmp: Bitmap): Rectangle; overload;
  
  /// Returns a bounding rectangle for a cell of the bitmap at the origin.
  /// 
  /// @lib BitmapCellRectangleAtOrigin
  /// @sn rectangleForBitmapCellAtOrigin:%s
  ///
  /// @class Bitmap
  /// @overload ToCellRectangle ToCellRectangleAtOrigin
  /// @csn toRectangleForCellAtOrigin
  function BitmapCellRectangle(bmp: Bitmap): Rectangle; overload;
  
  /// Returns a rectangle for a cell of the bitmap at the indicated point.
  /// 
  /// @lib BitmapCellRectangleXY
  /// @sn rectangleForCellAtX:%s y:%s forBitmapCell:%s
  ///
  /// @class Bitmap
  /// @method ToCellRectangle
  /// @self 3
  /// @csn toRectangleForCellAtX:%s y:%s
  function BitmapCellRectangle(x, y: Single; bmp: Bitmap): Rectangle; overload;
  
  /// Returns a rectangle for the location of the indicated cell within the
  /// bitmap.
  /// 
  /// @lib
  /// @sn bitmap:%s rectangleOfCell:%s
  /// 
  /// @class Bitmap
  /// @method CellRectangle
  /// @csn rectangleCell:%s
  function BitmapRectangleOfCell(src: Bitmap; cell: Longint): Rectangle;
  
  
  
//---------------------------------------------------------------------------
// Bitmap drawing routines - onto bitmap
//---------------------------------------------------------------------------

  /// Draw the bitmap using the passed in options
  ///
  /// @lib DrawBitmapWithOpts
  /// @sn drawBitmap:%s atX:%s y:%s withOptions:%s
  ///
  /// @class Bitmap
  /// @method DrawWithOpts
  /// @csn drawAtX:%s y:%s withOptions:%s
  procedure DrawBitmap(src: Bitmap; x, y: Single; const opts: DrawingOptions); overload;

  /// Draw the bitmap using the passed in options
  ///
  /// @lib DrawBitmapNamedWithOpts
  /// @sn drawBitmapNamed:%s atX:%s y:%s withOptions:%s
  procedure DrawBitmap(name: String; x, y: Single; const opts: DrawingOptions); overload;
  

//---------------------------------------------------------------------------
// Bitmap drawing routines - standard
//---------------------------------------------------------------------------
  
  /// Draw the passed in bitmap onto the game.
  ///
  /// @lib
  /// @sn draw:%s x:%s y:%s
  ///
  /// @class Bitmap
  /// @method Draw
  /// @csn drawAtX:%s y:%s
  ///
  /// @doc_idx 0
  procedure DrawBitmap(src : Bitmap; x, y : Single); overload;
  
  /// Draw the named bitmap onto the game.
  ///
  /// @lib DrawBitmapNamed
  /// @sn drawBitmapNamed:%s x:%s y:%s
  ///
  /// @doc_idx 1
  procedure DrawBitmap(name: String; x, y : Single); overload;
  
  /// Draw a cell from a bitmap onto the game.
  ///
  /// @lib DrawCellOpts
  /// @sn bitmap:%s drawCell:%s atX:%s y:%s opts:%s
  ///
  /// @class Bitmap
  /// @method DrawCell
  /// @csn drawCell:%s atX:%s y:%s opts:%s
  procedure DrawCell(src: Bitmap; cell: Longint; x, y: Single; const opts : DrawingOptions); overload;
  
  /// Draw a cell from a bitmap onto the game.
  ///
  /// @lib DrawCell
  /// @sn bitmap:%s drawCell:%s atX:%s y:%s
  ///
  /// @class Bitmap
  /// @method DrawCell
  /// @csn drawCell:%s atX:%s y:%s
  procedure DrawCell(src: Bitmap; cell: Longint; x, y: Single); overload;

    
//---------------------------------------------------------------------------
// Bitmap Saving
//---------------------------------------------------------------------------
  
  /// Save Bitmap to specific directory.
  /// 
  /// @lib
  /// @sn bitmap:%s saveToFile:%s
  ///
  /// @class Bitmap
  /// @method Save
  /// @csn saveToFile:%s
  procedure SaveBitmap(src : Bitmap; filepath : string);
  
  
  
//---------------------------------------------------------------------------
// Bitmap Transparancy
//---------------------------------------------------------------------------
  
  /// Setting the color passed in to be transparent on the bitmap. This edits the
  /// passed in bitmap, altering the color to transparent.
  /// 
  /// @lib
  /// @sn bitmap:%s setTransparentColor:%s
  ///
  /// @class Bitmap
  /// @method SetTransparentColor 
  procedure SetTransparentColor(src: Bitmap; clr:Color);
  
//=============================================================================
implementation
uses sgResources, sgCamera, sgGeometry, sgGraphics,
     sgDriverImages, sgDriver, sgDrawingOptions,
     stringhash,         // libsrc
     SysUtils, 
     sgSavePNG, sgShared, sgTrace;
//=============================================================================

var
  _Images: TStringHash;


//----------------------------------------------------------------------------


function CreateBitmap(width, height: Longint): Bitmap;
begin
  result := CreateBitmap('Bitmap', width, height);
end;

function CreateBitmap(name: String; width, height: Longint): Bitmap; overload;
var
  realName: String;
  idx: Longint;
  obj: tResourceContainer;
begin
  {$IFDEF TRACE}
    TraceEnter('sgImages', 'CreateBitmap');
  {$ENDIF}
  result := nil;
  
  if (width < 1) or (height < 1) then
  begin
    RaiseWarning('Bitmap width and height must be greater then 0');
    exit;
  end;
  
  New(result);
  result^.surface := nil;
  
  ImagesDriver.CreateBitmap(result, width, height);
  

  if (not Assigned(result)) or (not ImagesDriver.SurfaceExists(result)) then
  begin
    Dispose(result);
    result := nil;
    RaiseWarning('Failed to create a bitmap: ' + Driver.GetError());
    exit;
  end;
  
  //
  // Place the bitmap in the _Images hashtable
  //
  obj := tResourceContainer.Create(result);
  
  realName := name;
  idx := 0;
  
  while _Images.containsKey(realName) do
  begin
    realName := name + '_' + IntToStr(idx);
    idx := idx + 1;
  end;
  
  result^.width     := width;
  result^.height    := height;
  
  result^.cellW     := width;
  result^.cellH     := height;
  result^.cellCols  := 1;
  result^.cellRows  := 1;
  result^.cellCount := 1;
  
  result^.name      := realName;
  result^.filename  := '';
  
  ImagesDriver.InitBitmapColors(result);
  
  if not _Images.setValue(realName, obj) then
  begin
    FreeBitmap(result);
    RaiseException('Error creating bitmap: ' + realName);
    exit;
  end;
  
  {$IFDEF TRACE}
    TraceExit('sgImages', 'CreateBitmap', realName + ' = ' + HexStr(result));
  {$ENDIF}
end;

function CombineIntoGrid(const bitmaps: BitmapArray; cols: LongInt): Bitmap;
var
  i, w, h, rows: Integer;
  opts: DrawingOptions;
begin
  result := nil;
  w := 0;
  h := 0;
  
  for i := Low(bitmaps) to High(bitmaps) do
  begin
    if BitmapWidth(bitmaps[i]) > w then w := BitmapWidth(bitmaps[i]);
    if BitmapHeight(bitmaps[i]) > h then h := BitmapWidth(bitmaps[i]);
  end;
  
  if Length(bitmaps) < 1 then exit;
  if cols < 1 then exit;
  if (w = 0) or (h = 0) then exit;
  
  rows := Length(bitmaps) div cols;
  if Length(bitmaps) mod cols > 0 then 
    rows += 1;
  
  result := CreateBitmap(w * cols, h * rows);
  opts := OptionDrawTo(result);

  for i := Low(bitmaps) to High(bitmaps) do
  begin
    MakeOpaque(bitmaps[i]);
    DrawBitmap(bitmaps[i], (i mod cols) * w, (i div cols) * h, opts);
    MakeTransparent(bitmaps[i]);
  end;
  
  BitmapSetCellDetails(result, w, h, cols, rows, Length(bitmaps));
end;

function DoLoadBitmap(name, filename: String; transparent: Boolean; transparentColor: Color): Bitmap;
var
  obj: tResourceContainer;
begin
  {$IFDEF TRACE}
    TraceEnter('sgImages', 'LoadBitmap', filename);
  {$ENDIF}
  
  if _Images.containsKey(name) then
  begin
    result := BitmapNamed(name);
    exit;
  end;
  
  result := nil; //start at nil to exit cleanly on error
  
  // Check for file
  if not FileExists(filename) then
  begin
    filename := PathToResource(filename, BitmapResource);
    
    if not FileExists(filename) then
    begin
      RaiseWarning('Unable to locate bitmap ' + filename);
      exit;
    end;
  end;  
  
  result := ImagesDriver.DoLoadBitmap(filename, transparent, transparentColor);

  // if it failed to load then exit
  if not assigned(result) then 
  begin
    RaiseWarning('Error loading image ' + filename);
    exit;
  end;

  result^.cellW     := result^.width;
  result^.cellH     := result^.height;
  result^.cellCols  := 1;
  result^.cellRows  := 1;
  result^.cellCount := 1;
  result^.name      := name;
  result^.filename  := filename;
  SetLength(result^.clipStack, 0);
  
  // Place the bitmap in the _Images hashtable
  obj := tResourceContainer.Create(result);
  {$IFDEF TRACE}
    Trace('sgImages', 'Info', 'DoLoadBitmap', 'name = ' + name + ' obj = ' + HexStr(obj) + ' _Images = ' + HexStr(_Images));
  {$ENDIF}
  if not _Images.setValue(name, obj) then
  begin
    FreeBitmap(result);
    RaiseException('Error loaded Bitmap resource twice: ' + name + ' for file ' + filename);
    exit;
  end;
  
  {$IFDEF TRACE}
    TraceExit('sgImages', 'LoadBitmap, result = ' + HexStr(result));
  {$ENDIF}
end;

function LoadBitmap(filename: String; transparent: Boolean; transparentColor: Color): Bitmap; overload;
begin
  result := DoLoadBitmap(filename + ColorToString(transparentColor),filename, transparent, transparentColor);
end;

function LoadBitmap(filename: String): Bitmap; overload;
begin
  result := DoLoadBitmap(filename, filename, false, ColorBlack);
end;

function LoadTransparentBitmap(filename: String; transparentColor: Color): Bitmap; overload;
begin
  result := LoadBitmap(filename, true, transparentColor);
end;

procedure FreeBitmap(var bitmapToFree : Bitmap);
begin
  {$IFDEF TRACE}
    TraceEnter('sgImages', 'FreeBitmap', 'bitmapToFree = ' + HexStr(bitmapToFree));
  {$ENDIF}
  
  if Assigned(bitmapToFree) then
  begin    

    //Notify others that this is now gone!
    CallFreeNotifier(bitmapToFree);
    
    //Remove the image from the hashtable
    _Images.remove(BitmapName(bitmapToFree)).Free();
    
    ImagesDriver.FreeSurface(bitmapToFree);
    
    //Dispose the pointer
    Dispose(bitmapToFree);
  end;
  
  bitmapToFree := nil;
  
  {$IFDEF TRACE}
    TraceExit('sgImages', 'FreeBitmap');
  {$ENDIF}
end;


//----------------------------------------------------------------------------

function LoadBitmapNamed(name, filename: String): Bitmap;
begin
  {$IFDEF TRACE}
    TraceEnter('sgImages', 'LoadBitmapNamed', name + ' -> ' + filename);
  {$ENDIF}
  
  result := DoLoadBitmap(name, filename, false, ColorBlack);
  
  {$IFDEF TRACE}
    TraceExit('sgImages', 'LoadBitmapNamed');
  {$ENDIF}
end;

function LoadTransparentBitmapNamed(name, filename: String; transparentColor: Color): Bitmap;
begin
  {$IFDEF TRACE}
    TraceEnter('sgImages', 'LoadTransparentBitmapNamed', name + ' -> ' + filename);
  {$ENDIF}
  
  result := DoLoadBitmap(name, filename, true, transparentColor);
  
  {$IFDEF TRACE}
    TraceExit('sgImages', 'LoadTransparentBitmapNamed');
  {$ENDIF}
end;

function HasBitmap(name: String): Boolean;
begin
  result := _Images.containsKey(name);
end;

function BitmapNamed(name: String): Bitmap;
var
  tmp : TObject;
begin
  {$IFDEF TRACE}
    TraceEnter('sgImages', 'BitmapNamed', 'name = ' + name);
  {$ENDIF}
  tmp := _Images.values[name];
  if assigned(tmp) then
    result := Bitmap(tResourceContainer(tmp).Resource)
  else 
  begin
    RaiseWarning('Unable to find bitmap named: ' + name);
    result := nil;
  end;
  {$IFDEF TRACE}
    TraceExit('sgImages', 'BitmapNamed = ' + HexStr(result));
  {$ENDIF}
end;

procedure ReleaseBitmap(name: String);
var
  bmp: Bitmap;
begin
  {$IFDEF TRACE}
    TraceEnter('sgImages', 'ReleaseBitmap', 'name = ' + name);
  {$ENDIF}
  
  bmp := BitmapNamed(name);
  if (assigned(bmp)) then
  begin
    FreeBitmap(bmp);
  end;
  {$IFDEF TRACE}
    TraceExit('sgImages', 'ReleaseBitmap');
  {$ENDIF}
end;

procedure ReleaseAllBitmaps();
begin
  ReleaseAll(_Images, @ReleaseBitmap);
end;

//----------------------------------------------------------------------------

function PixelDrawnAtPoint(bmp: Bitmap; x, y: Single): Boolean;
begin
  if not assigned(bmp) then result := false
  else result := (Length(bmp^.nonTransparentPixels) = bmp^.width)
      and ((x >= 0) and (x < bmp^.width))
      and ((y >= 0) and (y < bmp^.height))
      and bmp^.nonTransparentPixels[Round(x), Round(y)];
end;

procedure BitmapSetCellDetails(bmp: Bitmap; width, height, columns, rows, count: Longint);
begin
  if not assigned(bmp) then exit;
  
  bmp^.cellW     := width;
  bmp^.cellH     := height;
  bmp^.cellCols  := columns;
  bmp^.cellRows  := rows;
  bmp^.cellCount := count;
end;

function BitmapCellCount(bmp: Bitmap): Longint;
begin
  if not assigned(bmp) then result := 0
  else result := bmp^.cellCount;
end;

function BitmapCellRows(bmp: Bitmap): Longint;
begin
  if not assigned(bmp) then result := 0
  else result := bmp^.cellRows;
end;

function BitmapCellColumns(bmp: Bitmap): Longint;
begin
  if not assigned(bmp) then result := 0
  else result := bmp^.cellCols;
end;

function BitmapsInterchangable(bmp1, bmp2: Bitmap): Boolean;
begin
  if (not assigned(bmp1)) or (not assigned(bmp2)) then
    result := false
  else
    result := (bmp1^.cellCount = bmp2^.cellCount) and
              (bmp1^.cellW = bmp2^.cellW) and
              (bmp1^.cellH = bmp2^.cellH);
end;


//---------------------------------------------------------------------------

procedure MakeOpaque(bmp: Bitmap);
begin
  ImagesDriver.MakeOpaque(bmp);
end;

procedure SetOpacity(bmp: Bitmap; pct: Single);
begin
  ImagesDriver.SetOpacity(bmp, pct)
end;

procedure MakeTransparent(bmp: Bitmap);
begin
  ImagesDriver.MakeTransparent(bmp);
end;

procedure SetupBitmapForCollisions(src: Bitmap);
begin
  if not assigned(src) then exit;
  if Length(src^.nonTransparentPixels) <> 0 then exit;
    
  ImagesDriver.SetNonAlphaPixels(src);
  OptimiseBitmap(src);
end;

//---------------------------------------------------------------------------

procedure OptimiseBitmap(surface: Bitmap);
begin
  ImagesDriver.OptimiseBitmap(surface);
end;

//---------------------------------------------------------------------------

/// Draws one bitmap (src) onto another bitmap (dest).
///
/// @param dest:         The destination bitmap - not optimised!
/// @param src: The bitmap to be drawn onto the destination
/// @param x,y:         The x,y location to draw the bitmap to
///
/// Side Effects:
/// - Draws the src at the x,y location in the destination.

procedure DrawBitmap(src: Bitmap; x, y: Single; const opts: DrawingOptions); overload;
begin
  {$IFDEF TRACE}
    TraceEnter('sgImages', 'DrawBitmap', 'src = ' + HexStr(src));
    try
  {$ENDIF}

  if (not Assigned(opts.dest)) or (not Assigned(src)) then exit;
  
  ImagesDriver.BlitSurface(src, x, y, opts)

  {$IFDEF TRACE}
    finally
      TraceExit('sgImages', 'DrawBitmap');
    end;
  {$ENDIF}
end;

procedure DrawBitmap(src: Bitmap; x, y : Single); overload;
begin
  DrawBitmap(src, x, y, OptionDefaults());
end;

procedure DrawBitmap(name: String; x, y : Single; const opts: DrawingOptions); overload;
begin
    DrawBitmap(BitmapNamed(name), x, y, opts);
end;

procedure DrawBitmap(name: String; x, y : Single); overload;
begin
  DrawBitmap(BitmapNamed(name), x, y, OptionDefaults());
end;

//---------------------------------------------------------------------------

procedure ClearSurface(dest: Bitmap; toColor: Color); overload;
begin
  ImagesDriver.ClearSurface(dest, toColor);
end;

procedure ClearSurface(dest: Bitmap); overload;
begin
  ClearSurface(dest, ColorBlack);
end;

//---------------------------------------------------------------------------

procedure DrawCell(src: Bitmap; cell: Longint; x, y: Single; const opts : DrawingOptions); overload;
begin
  DrawBitmap(src, x, y, OptionPartBmp(BitmapRectangleOfCell(src, cell), opts));
end;

procedure DrawCell(src: Bitmap; cell: Longint; x, y: Single); overload;
begin
  DrawCell(src, cell, x, y, OptionDefaults());
end;

//---------------------------------------------------------------------------

function BitmapRectangle(x, y: Single; bmp: Bitmap): Rectangle; overload;
begin
  if not Assigned(bmp) then result := RectangleFrom(0,0,0,0)
  else result := RectangleFrom(x, y, bmp^.width, bmp^.height);
end;

function BitmapRectangle(bmp: Bitmap): Rectangle; overload;
begin
  result := BitmapRectangle(0,0,bmp);
end;

function BitmapCellRectangle(x, y: Single; bmp: Bitmap): Rectangle; overload;
begin
  if not Assigned(bmp) then result := RectangleFrom(0,0,0,0)
  else result := RectangleFrom(x, y, bmp^.cellW, bmp^.cellH);
end;

function BitmapCellRectangle(bmp: Bitmap): Rectangle; overload;
begin
  result := BitmapCellRectangle(0, 0, bmp);
end;

function BitmapRectangleOfCell(src: Bitmap; cell: Longint): Rectangle;
begin
  if (not assigned(src)) or (cell >= src^.cellCount) then
    result := RectangleFrom(0,0,0,0)
  else if (cell < 0) then
  begin
    result := RectangleFrom(0,0,BitmapWidth(src),BitmapHeight(src));
  end
  else
  begin
    result.x := (cell mod src^.cellCols) * src^.cellW;
    result.y := (cell - (cell mod src^.cellCols)) div src^.cellCols * src^.cellH;
    result.width := src^.cellW;
    result.height := src^.cellH;
  end;
end;

function BitmapWidth(bmp: Bitmap): Longint; overload;
begin
  if not assigned(bmp) then result := 0
  else result := bmp^.width;
end;

function BitmapHeight(bmp: Bitmap): Longint; overload;
begin
  if not assigned(bmp) then result := 0
  else result := bmp^.height;
end;

function BitmapCellWidth(bmp: Bitmap): Longint;
begin
  if not assigned(bmp) then result := 0
  else result := bmp^.cellW;
end;

function BitmapCellHeight(bmp: Bitmap): Longint;
begin
  if not assigned(bmp) then result := 0
  else result := bmp^.cellH;
end;

function BitmapName(bmp:Bitmap): string;
begin
  result:= '';
  if not assigned(bmp) then exit;
  result:=bmp^.name;
end;

function BitmapFilename(bmp:Bitmap): string;
begin
  result:= '';
  if not assigned(bmp) then exit;
  result:=bmp^.filename;
end;

function BitmapCircle(bmp: Bitmap; x, y: Single): Circle; overload;
begin
  result := BitmapCircle(bmp, PointAt(x, y));
end;

function BitmapCircle(bmp: Bitmap; const pt: Point2D): Circle; overload;
begin
  {$IFDEF TRACE}
    TraceEnter('sgImages', 'BitmapCircle', '');
  {$ENDIF}
  
  result.center := pt;
  
  if BitmapWidth(bmp) > BitmapHeight(bmp) then
    result.radius := RoundInt(BitmapWidth(bmp) / 2.0)
  else
    result.radius := RoundInt(BitmapHeight(bmp) / 2.0);
  
  {$IFDEF TRACE}
    TraceExit('sgImages', 'BitmapCircle', '');
  {$ENDIF}
end;


function BitmapCellCircle(bmp: Bitmap; x, y: Single): Circle; overload;
begin
  result := BitmapCellCircle(bmp, PointAt(x, y));
end;

function BitmapCellCircle(bmp: Bitmap; const pt: Point2D): Circle; overload;
begin
  {$IFDEF TRACE}
    TraceEnter('sgImages', 'BitmapCellCircle', '');
  {$ENDIF}
  
  result.center := pt;
  
  if BitmapCellWidth(bmp) > BitmapCellHeight(bmp) then
    result.radius := RoundInt(BitmapCellWidth(bmp) / 2.0)
  else
    result.radius := RoundInt(BitmapCellHeight(bmp) / 2.0);
  
  {$IFDEF TRACE}
    TraceExit('sgImages', 'BitmapCellCircle', '');
  {$ENDIF}
end;

//---------------------------------------------------------------------------

procedure SaveBitmap(src: Bitmap; filepath: String);
begin
  ImagesDriver.SaveBitmap(src, filepath);
end;

//---------------------------------------------------------------------------

procedure SetTransparentColor(src: Bitmap; clr:Color);
var
  x,y : integer;
begin
  if not assigned(src) then exit;
  
  for x:= 0 to src^.Width - 1 do
  begin
    for y := 0 to src^.Height - 1 do
    begin
      if (GetPixel(src, x, y) = clr) then 
        DrawPixel(RGBAColor(0,0,0,0),x,y, OptionDrawTo(src));
    end;
  end;
end;

procedure SaveToPNG(bmp: Bitmap; filename: String);
begin
  if not assigned(bmp) then exit;
  
  ImagesDriver.SaveBitmap(bmp, filename);
end;


//=============================================================================

  initialization
  begin
    {$IFDEF TRACE}
      TraceEnter('sgImages', 'initialization');
    {$ENDIF}
    
    InitialiseSwinGame();
    
    _Images := TStringHash.Create(False, 1024);
    
    {$IFDEF TRACE}
      TraceExit('sgImages', 'initialization');
    {$ENDIF}
  end;
  
  finalization
  begin
    ReleaseAllBitmaps();
    FreeAndNil(_Images);
  end;
//=============================================================================

end.
//=============================================================================
