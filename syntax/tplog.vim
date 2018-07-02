if exists("b:currect_syntax)
  finish
endif

" Define keywords in log file
syn keyword logKeyword DEBUG INFO WARN TRACE
hi link logKeyword Keyword

syn keyword logError ERROR
hi link logError Error

" Rules for log line, connection id and datetime
syn match logHeader "^CID-" contains=logConnectionId,logDatetime 
syn match logConnectionId "{[0-9a-zA-Z]*}"
syn match logDatetime "[0-9]\{4}-[0-9]\{2}-[0-9]\{2} [0-9]\{2}:[0-9]\{2}:[0-9]\{2},[0-9]\{3}"

hi link logHeader Ignore
hi link logConnectionId Number
hi link logDatetime Structure

" Embedded XML document PBR's
syn match  logXMLComment    '"[^"]*"'
syn match  logXMLCommentHigh    '"[^"]*"'
syn region logPBRField start="<ns1:field" end="/>" contains=logXMLComment keepend
syn region logPBRTransactionTypeField start='<ns1:field ns1:ID="\(TRANSACTIONTYPE\|POSID\|TERMINAL_TYPE\|DEVICEURI\|GATEWAY_TYPE\|GIFT_GATEWAY_TYPE\)"' end="/>" contains=logXMLCommentHigh keepend
syn region logPBRXML start="<?xml version" end="</.*>" contains=logPBRField,logPBRTransactionTypeField extend

hi def boldComment term=bold cterm=bold gui=bold

hi link logPBRXML Comment
hi link logPBRField Comment
hi link logXMLComment Type 
hi link logXMLCommentHigh boldComment
hi link logPBRTransactionTypeField Number 

let b:currect_syntax="tplog"
