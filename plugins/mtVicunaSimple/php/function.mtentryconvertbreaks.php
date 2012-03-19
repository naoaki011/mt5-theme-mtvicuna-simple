<?php
function smarty_function_mtentryconvertbreaks($args, &$ctx) {
    $entry = $ctx->stash('entry');
    if (!$entry) {
         return $ctx->error('You used an MTEntryConvertBreaks tag outside of the proper context.');
    }
    $convert_breaks = $entry->convert_breaks ? $entry->convert_breaks : 0;
    return $convert_breaks;
}
?>
