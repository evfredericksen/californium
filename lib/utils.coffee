{Disposable, CompositeDisposable, Point} = require 'atom'

disposables = new CompositeDisposable()

REGEX_PATTERNS =
  'wi': new RegExp('^|[^a-zA-Z0-9_-\\s]+|[a-zA-Z0-9_-]+')
  'wa': new RegExp('^|[^a-zA-Z0-9_-\\s]+\\s*|[a-zA-Z0-9_-]+\\s*')

CHARS =
  32: ' '
  33: '!'
  34: '"'
  35: '#'
  36: '$'
  37: '%'
  38: '&'
  39: "'"
  40: '('
  41: ')'
  42: '*'
  43: '+'
  44: ','
  45: '-'
  46: '.'
  47: '/'
  48: '0'
  49: '1'
  50: '2'
  51: '3'
  52: '4'
  53: '5'
  54: '6'
  55: '7'
  56: '8'
  57: '9'
  58: ':'
  59: ';'
  60: '<'
  61: '='
  62: '>'
  63: '?'
  64: '@'
  65: 'A'
  66: 'B'
  67: 'C'
  68: 'D'
  69: 'E'
  70: 'F'
  71: 'G'
  72: 'H'
  73: 'I'
  74: 'J'
  75: 'K'
  76: 'L'
  77: 'M'
  78: 'N'
  79: 'O'
  80: 'P'
  81: 'Q'
  82: 'R'
  83: 'S'
  84: 'T'
  85: 'U'
  86: 'V'
  87: 'W'
  88: 'X'
  89: 'Y'
  90: 'Z'
  97: 'a'
  98: 'b'
  99: 'c'
  100: 'd'
  101: 'e'
  102: 'f'
  103: 'g'
  104: 'h'
  105: 'i'
  106: 'j'
  107: 'k'
  108: 'l'
  109: 'm'
  110: 'n'
  111: 'o'
  112: 'p'
  113: 'q'
  114: 'r'
  115: 's'
  116: 't'
  117: 'u'
  118: 'v'
  119: 'w'
  120: 'x'
  121: 'y'
  122: 'z'

getLastPos = (editor) ->
  lastRow = editor.getLastBufferRow()
  lastCol = editor.lineTextForBufferRow(lastRow).length
  new Point(lastRow, lastCol)

moveForwards = (editor, startPoint, totalCount) ->
  count = 0
  lastPos = getLastPos(editor)
  [row, col] = startPoint.toArray()
  lineLength = editor.lineTextForBufferRow(row).length
  while count < totalCount and lastPos.isGreaterThan([x, y])
    if col >= lineLength
      row++
      col = 0
      lineLength = editor.lineTextForBufferRow(row).length
    else
      col++
    count++
  new Point(row, col)

moveBackwards = (editor, startPoint, totalCount) ->
  count = 0
  [row, col] = startPoint.toArray()
  while count < totalCount and Math.max(row, col) > 0
    if col == 0
      row--
      col = editor.lineTextForBufferRow(row).length
    else
      col--
    count++
  new Point(row, col)

module.exports = {
    CHARS
    REGEX_PATTERNS
    getLastPos
    moveForwards
    moveBackwards
}
