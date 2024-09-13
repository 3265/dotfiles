/**
 * 色を12段階で自動で変えるスクリプト。
 */

function myFunction() {
}

function onOpen() {
}


var colorSet = [
  {bg:"#AED6F1", txt: "black", fs: "11", fw: "normal"},  // パステルブルー
  {bg:"#A3E4D7", txt: "black", fs: "11", fw: "normal"},  // パステルグリーン
  {bg:"#F5B7B1", txt: "black", fs: "11", fw: "normal"},  // パステルレッド
  {bg:"#FAD7A0", txt: "black", fs: "11", fw: "normal"},  // パステルオレンジ
  {bg:"#D7BDE2", txt: "black", fs: "11", fw: "normal"},  // パステルパープル
  {bg:"#A2D9CE", txt: "black", fs: "11", fw: "normal"},  // パステルターコイズ
  {bg:"#F9E79F", txt: "black", fs: "11", fw: "normal"},  // パステルイエロー
  {bg:"#D5DBDB", txt: "black", fs: "11", fw: "normal"},  // パステルグレー
  {bg:"#ABEBC6", txt: "black", fs: "11", fw: "normal"},  // ライトグリーン
  {bg:"#F5CBA7", txt: "black", fs: "11", fw: "normal"},  // ライトオレンジ
  {bg:"#AED6F1", txt: "black", fs: "11", fw: "normal"},  // ライトブルー
  {bg:"#F9E79F", txt: "black", fs: "11", fw: "normal"},  // ライトイエロー
]


var colorLen = colorSet.length;

var targetWord = "Plan"

function onEdit(event)
{
  var cellValue = event.value;
  var cellOldValue = event.oldValue
  var ss = event.range.getSheet();
  var selectedRange = event.range // {columnEnd: 7, columnStart: 6, rowEnd: 68, rowStart: 66}
  var sheetName = ss.getName();
  var changedCell = event.source.getActiveCell();
  var colName = changedCell.getColumn();
  var rowName = changedCell.getRow();
  var eventSourceValue = event.source.getActiveSheet().getActiveCell().getValue();
　var rowCount = selectedRange.rowEnd-selectedRange.rowStart + 1;
  var valuesInRange = event.range.getValue()
  var valueLengthInRange = event.range.getValue().length;
  var isInsertTest = cellValue == eventSourceValue
  var isCutAction = event.range.getValue().length == 0
  var isValueEdited = cellValue !== cellOldValue

  // debug
  console.log(
    "sheetName=", sheetName,
    ",colName=", colName,
    ",rowName=", rowName,
    ",cellValue=", cellValue,
    ",cellOldValue=", cellOldValue,
    ",selectedRange=", selectedRange,
    ",eventSourceValue=", eventSourceValue,
    ",rowCount=", rowCount,
    ",valuesInRange=", valuesInRange,
    ",valueLengthInRange", valueLengthInRange,
    ",isInsertTest=", isInsertTest,
    ",isCutAction=", isCutAction,
    ",isValueEdited=", isValueEdited
  );

  // 特定のシートだけ
  if (!sheetName.includes(targetWord)) return

  // 特定の列のみ
  if (colName > colorLen) {
    return;
  }

  // 重いかもしれないから 20行以上の処理はスキップ
  if (rowCount > 20)  {
      return;
  }

  // 矩形削除かを判別
  // https://stackoverflow.com/questions/13718269/google-apps-script-how-to-get-the-deleted-row-in-onedit-script-or-ondelete
  if (isInsertTest) {
    // if there is no value then don't make color
    if (!cellValue) {
      return;
    }

    // reset colors
    resetColor(ss, rowName)

    // make colorful
    // setColorGradation(ss, rowName)
    if (cellValue == "Test") {
      setColorGradation(ss, rowName, colName)
    } else {
      setColorBar(ss, rowName, colName)
    }
  } else {
    if (!isValueEdited) {
      return;
    }

    //Things to do if cell was deleted
    deleted_range = selectedRange
    console.log("DELETED RANGE: ", deleted_range)
    for (var i=0;i< rowCount; i++) {
      resetColor(ss, selectedRange.rowStart + i)
    }
  }
}

// カラーをリセットする
function resetColor(ss, rowName) {
  for (var i =0; i<colorLen; i++) {
    var colIdx = i+1; // indexが0から始まっているので、colNameにするため、+1する
    range = ss.getRange(rowName, colIdx)
    range.setBackground(null);
    range.setFontColor(null);
    range.setFontStyle(null)
    range.setFontSize(10)
    // range.setValue(null);
  }
}

// グラデーションをつくる
function setColorGradation(ss, rowName) {
  for (var i =0; i<colorLen; i++) {
    var colIdx = i+1; // indexが0から始まっているので、colNameにするため、+1する
    var colorObj = colorSet[i];
    range = ss.getRange(rowName, colIdx)
    range.setBackground(colorObj.bg);
    range.setFontColor(colorObj.txt);
    range.setFontSize(colorObj.fs);
    range.setFontWeight(colorObj.fw)
  }
}

// カラーのバーをつくる
function setColorBar(ss, rowName, colName) {
  var colorObj = colorSet[colName-1]
  for (var i =0; i<colorLen-colName+2; i++) {
    if (i===0) {
      continue;
    }
    //console.log("I", i)
    //console.log("colName", colName)

    var colIdx = colName + i - 1;
    range = ss.getRange(rowName, colIdx)
    range.setBackground(colorObj.bg);
    range.setFontColor(colorObj.txt);
    range.setFontSize(colorObj.fs);
    range.setFontWeight(colorObj.fw);
  }
}

