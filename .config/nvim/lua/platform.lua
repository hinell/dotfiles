-- Created-at: Wednesday, December 21, 2022
-- Platform standard classes
-- TODO: Rewrite by using classes/metatables
-------------------------------------------------------------------------String
String = { insert }
-- I'm inserting a string at specified position insider another one
-- @param str1 - Target string
-- @param pos  - Position at which to insert
-- @param str2 - String for insertion at pos
-- @return A str1 with inserted str2
String.insert = function (str1, pos, str2)
  return str1:sub(1,pos)..str2..str1:sub(pos+1)
end
