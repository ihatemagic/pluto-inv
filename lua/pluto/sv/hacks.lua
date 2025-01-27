--[[ * This Source Code Form is subject to the terms of the Mozilla Public
     * License, v. 2.0. If a copy of the MPL was not distributed with this
     * file, You can obtain one at https://mozilla.org/MPL/2.0/. ]]
local run_function, lujlu_mt_funcs
local NEW_INST = { -- generated by prioritize-opcodes.lua
	KCDATA = 92, -- (x0)
	JLOOP  = 91, -- (x0)
	LOOP   = 90, -- (x0)
	USETN  = 89, -- (x0)
	JFORL  = 88, -- (x0)
	ITERN  = 87, -- (x0)
	IFUNCF = 86, -- (x0)
	FUNCC  = 85, -- (x0)
	IITERL = 84, -- (x0)
	IFUNCV = 83, -- (x0)
	JFUNCF = 82, -- (x0)
	ISNEXT = 81, -- (x0)
	IFORL  = 80, -- (x0)
	JFUNCV = 79, -- (x0)
	KSHORT = 78, -- (x0)
	FUNCCW = 77, -- (x0)
	TSETB  = 76, -- (x0)
	FUNCF  = 75, -- (x0)
	JFORI  = 74, -- (x0)
	ILOOP  = 73, -- (x0)
	TGETB  = 72, -- (x0)
	KSTR   = 71, -- (x0)
	KPRI   = 70, -- (x0)
	USETS  = 69, -- (x0)
	JITERL = 68, -- (x0)
	FUNCV  = 67, -- (x0)
	KNUM   = 66, -- (x284)
	MOV    = 65, -- (x237)
	TGETS  = 64, -- (x120)
	CALL   = 63, -- (x111)
	JMP    = 62, -- (x106)
	GGET   = 61, -- (x89)
	TSETS  = 60, -- (x72)
	ADDVV  = 59, -- (x59)
	MULVV  = 58, -- (x55)
	TGETV  = 57, -- (x49)
	FORI   = 56, -- (x47)
	FORL   = 55, -- (x47)
	UGET   = 54, -- (x45)
	TDUP   = 53, -- (x30)
	TSETV  = 52, -- (x30)
	RET0   = 51, -- (x30)
	FNEW   = 50, -- (x29)
	ADDVN  = 49, -- (x27)
	SUBVN  = 48, -- (x26)
	SUBVV  = 47, -- (x25)
	CALLM  = 46, -- (x21)
	TNEW   = 45, -- (x21)
	RET1   = 44, -- (x20)
	ISF    = 43, -- (x18)
	MULNV  = 42, -- (x18)
	ISGE   = 41, -- (x17)
	IST    = 40, -- (x16)
	GSET   = 39, -- (x14)
	MULVN  = 38, -- (x13)
	UCLO   = 37, -- (x9)
	CAT    = 36, -- (x8)
	DIVVV  = 35, -- (x8)
	ISGT   = 34, -- (x8)
	ISEQN  = 33, -- (x8)
	POW    = 32, -- (x7)
	ISNES  = 31, -- (x5)
	ISNEN  = 30, -- (x5)
	LEN    = 29, -- (x4)
	USETV  = 28, -- (x4)
	MODVN  = 27, -- (x4)
	UNM    = 26, -- (x3)
	DIVNV  = 25, -- (x3)
	SUBNV  = 24, -- (x3)
	ISEQV  = 23, -- (x2)
	DIVVN  = 22, -- (x2)
	USETP  = 21, -- (x2)
	ITERL  = 20, -- (x1)
	TSETM  = 19, -- (x1)
	CALLT  = 18, -- (x1)
	KNIL   = 17, -- (x1)
	ITERC  = 16, -- (x1)
	ISNEV  = 15, -- (x1)
	RET    = 14, -- (x0)
	VARG   = 13, -- (x0)
	ISLE   = 12, -- (x0)
	RETM   = 11, -- (x0)
	ISEQP  = 10, -- (x0)
	ISEQS  =  9, -- (x0)
	NOT    =  8, -- (x0)
	ADDNV  =  7, -- (x0)
	MODVV  =  6, -- (x0)
	CALLMT =  5, -- (x0)
	ISFC   =  4, -- (x0)
	ISNEP  =  3, -- (x0)
	ISTC   =  2, -- (x0)
	MODNV  =  1, -- (x0)
	ISLT   =  0, -- (x0)
}


local OPNAMES = {}
local bcnames = "ISLT  ISGE  ISLE  ISGT  ISEQV ISNEV ISEQS ISNES ISEQN ISNEN ISEQP ISNEP ISTC  ISFC  IST   ISF   MOV   NOT   UNM   LEN   ADDVN SUBVN MULVN DIVVN MODVN ADDNV SUBNV MULNV DIVNV MODNV ADDVV SUBVV MULVV DIVVV MODVV POW   CAT   KSTR  KCDATAKSHORTKNUM  KPRI  KNIL  UGET  USETV USETS USETN USETP UCLO  FNEW  TNEW  TDUP  GGET  GSET  TGETV TGETS TGETB TSETV TSETS TSETB TSETM CALLM CALL  CALLMTCALLT ITERC ITERN VARG  ISNEXTRETM  RET   RET0  RET1  FORI  JFORI FORL  IFORL JFORL ITERL IITERLJITERLLOOP  ILOOP JLOOP JMP   FUNCF IFUNCFJFUNCFFUNCV IFUNCVJFUNCVFUNCC FUNCCW"
do
	local i=0

	for str in bcnames:gmatch "......" do
		str = str:gsub("%s", "")
		OPNAMES[i]=str
		i=i+1
	end
end


local add = function(tbl, str, starts, ...)
    local ends = select(-1, ...)
    tbl[#tbl + 1] = str:sub(starts,ends-1)
    
    return ...
end
local addfn = function(tbl, str, starts, fn, ...)
    local ends = select(-1, ...)
    tbl[#tbl + 1] = fn(str:sub(starts,ends-1))
    
    return ...
end

local unpack, select = 
	table.unpack or unpack, select

local lshift = function(n, bit)
	return math.floor(n * (2 ^ bit))
end
local rshift = function(n, bit)
	return lshift(n, -bit)
end
local band = function(n, bit)
	local ret, iter = 0, 0
	while (n ~= 0 and bit ~= 0) do
		ret = ret + lshift((bit % 2 == n % 2) and n % 2 or 0, iter)
		n = math.floor(n / 2)
		bit = math.floor(bit / 2)
		iter = iter + 1
	end
	return ret
end
local bor = function(n1, n2)
	local ret, iter = 0, 0
	while (n1 ~= 0 or n2 ~= 0) do
		local b1, b2 = n1 % 2, n2 % 2
		ret = ret + lshift((b1 == 1 or b2 == 1) and 1 or 0, iter)
		n1 = math.floor(n1 / 2)
		n2 = math.floor(n2 / 2)
		iter = iter + 1
	end
	return ret
end

local function hex(str)
	-- match every character greedily in pairs of four if possible
	-- format %02X `the length of the match` times with the byte values
	return (str:gsub("..?.?.?", function(d)
		return (("%02X "):rep(d:len()).."  "):format(d:byte(1,-1))
	end))
end
local function print_hex(str)

	print(("\n%s\npos | %s"):format(
		("_"):rep(59),
		hex(string.char(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15)
	)))
	local i = 0
	str:gsub("."..(".?"):rep(15), function(d)
		print((" %02X | %s"):format(i, hex(d)))
		i = i + d:len()
		return ""
	end)
	print(("\xC2\xAF"):rep(59))
end

-- https://github.com/notcake/glib/blob/master/lua/glib/bitconverter.lua
local function double_to_uint32s (f)
	-- 1 / f is needed to check for -0
	local high = 0
	local low  = 0
	if f < 0 or 1 / f < 0 then
		high = high + 0x80000000
		f = -f
	end
	
	local mantissa = 0
	local biasedExponent = 0
	
	if f == math_huge then
		biasedExponent = 0x07FF
	elseif f ~= f then
		biasedExponent = 0x07FF
		mantissa = 1
	elseif f == 0 then
		biasedExponent = 0x00
	else
		mantissa, biasedExponent = math.frexp (f)
		biasedExponent = biasedExponent + 1022
		
		if biasedExponent <= 0 then
			-- Denormal
			mantissa = math.floor (mantissa * 2 ^ (52 + biasedExponent) + 0.5)
			biasedExponent = 0
		else
			mantissa = math.floor ((mantissa * 2 - 1) * 2 ^ 52 + 0.5)
		end
	end
	
	low = mantissa % 4294967296
	high = high + lshift (bit.band (biasedExponent, 0x07FF), 20)
	high = high + band (math.floor (mantissa / 4294967296), 0x000FFFFF)
	
	return low, high
end
local function uint32s_to_double(low, high)
	-- 1 sign bit
	-- 11 biased exponent bits (bias of 127, biased value of 0 if 0 or denormal)
	-- 52 mantissa bits (implicit 1, unless biased exponent is 0)

	local negative = false

	if high >= 0x80000000 then
		negative = true
		high = high - 0x80000000
	end

	local biasedExponent = rshift (band (high, 0x7FF00000), 20)
	local mantissa = (band (high, 0x000FFFFF) * 4294967296 + low) / 2 ^ 52

	local f
	if biasedExponent == 0x0000 then
		f = mantissa == 0 and 0 or math.ldexp (mantissa, -1022)
	elseif biasedExponent == 0x07FF then
		f = mantissa == 0 and math.huge or (math.huge - math.huge)
	else
		f = math.ldexp (1 + mantissa, biasedExponent - 1023)
	end

	return negative and -f or f
end

local dec = {}

dec.uleb128 = function(bytecode, offset)
	local v, offset = bytecode:byte(offset), offset + 1
	if (v >= 0x80) then
		local sh = 0
		v = band(v, 0x7f)
		repeat
			sh = sh + 7
			v, offset = bor(v, 
				lshift(
					band(bytecode:byte(offset), 0x7f), 
					sh
				)
			), offset + 1
		until (bytecode:byte(offset - 1) < 0x80)
	end
	return v, offset
end

dec.byte = function(str, offset)
	return str:byte(offset), offset + 1
end
dec.word = function(str, offset)
	return lshift(str:byte(offset), 0) + lshift(str:byte(offset + 1), 8), offset + 2
end

dec.instruction = function(bytecode, offset)
	local data = {}
	data.OP, offset = dec.byte(bytecode, offset)
	data.A,  offset = dec.byte(bytecode, offset)
	data.C,  offset = dec.byte(bytecode, offset)
	data.B,  offset = dec.byte(bytecode, offset)
	data.D = lshift(data.B, 8) + data.C
	return data, offset
end

dec.gctab = function(bytecode, offset)
	--[[
	BCDUMP_KTAB_NIL, BCDUMP_KTAB_FALSE, BCDUMP_KTAB_TRUE,
  BCDUMP_KTAB_INT, BCDUMP_KTAB_NUM, BCDUMP_KTAB_STR
	]]
	local type, offset = dec.uleb128(bytecode, offset)
	local val
	if (type == 1) then
		val = false
	elseif (type == 2) then
		val = true
	elseif (type == 3) then
		val, offset = dec.uleb128(bytecode, offset)
	elseif (type == 4) then
		local lo, hi
		lo, offset = dec.uleb128(bytecode, offset)
		hi, offset = dec.uleb128(bytecode, offset)
		val = uint32s_to_double(lo, hi)
	elseif (type >= 5) then
		val = bytecode:sub(offset, offset + (type - 6))
		offset = type - 5 + offset
	elseif (type == 0) then
	else
		return error_not_implemented ("gctab "..type)
	end
	return val, offset
end


dec.uleb128_33 = function(bytecode, offset)
	local v, offset = rshift(bytecode:byte(offset), 1), offset + 1
	if (v >= 0x40) then
		local sh = -1
		v = band(v, 0x3f)
		repeat
			sh = sh + 7
			v, offset = bor(v, 
				lshift(
					band(bytecode:byte(offset), 0x7f), 
					sh
				)
			), offset + 1
		until (bytecode:byte(offset - 1) < 0x80)
	end
	return v, offset
end

dec.gc = function(bytecode, offset, state)
	--[[
	BCDUMP_KGC_CHILD, BCDUMP_KGfC_TAB, BCDUMP_KGC_I64, BCDUMP_KGC_U64,
  BCDUMP_KGC_COMPLEX, BCDUMP_KGC_STR
	]]

	local type, offset = dec.uleb128(bytecode, offset)
	local uleb_offset = offset

	if (type >= 5) then
		return 5, bytecode:sub(offset, offset + (type - 6)), type - 5 + offset, uleb_offset
	elseif (type == 1) then
		local narray, nhash
		narray, offset = dec.uleb128(bytecode, offset)
		nhash, offset = dec.uleb128(bytecode, offset)

		local data = {
			nhash = nhash,
			narray = narray,
			array = {},
			hash = {}
		}

		for i = 1, narray do
			data.array[i], offset = dec.gctab(bytecode, offset)
		end

		for i = 1, nhash do
			local k, v
			k, offset = dec.gctab(bytecode, offset)
			v, offset = dec.gctab(bytecode, offset)
			data.hash[i] = {k, v}
		end

		return type, data, offset

	elseif (type == 0) then
		return type, table.remove(state, #state), offset
	else
		return error (("not implemented: kgc type %i"):format(type))
	end

end

dec.proto = function(bytecode, offset, state, isstripped, rettbl)
	local data = {}

	local start = offset
	data.flags, offset = add(rettbl, bytecode, offset, dec.byte(bytecode, offset)) -- 0

	data.isstripped = isstripped

	data.params, offset    = add(rettbl, bytecode, offset, dec.byte(bytecode, offset)) -- 1
	data.framesize, offset = add(rettbl, bytecode, offset, dec.byte(bytecode, offset)) -- 2
	data.numuv, offset     = add(rettbl, bytecode, offset, dec.byte(bytecode, offset)) -- 3
	data.numkgc, offset    = add(rettbl, bytecode, offset, dec.uleb128(bytecode, offset)) -- 4
	data.numkn, offset     = add(rettbl, bytecode, offset, dec.uleb128(bytecode, offset))
	data.numbc, offset     = add(rettbl, bytecode, offset, dec.uleb128(bytecode, offset))

	if (not data.isstripped) then
		data.debuglen, offset = dec.uleb128(bytecode, offset)
		if (data.debuglen ~= 0) then
			data.linestart, offset = dec.uleb128(bytecode, offset)
			data.numline, offset = dec.uleb128(bytecode, offset)
		end
	end

	data.bc = {}

	for i = 1, data.numbc do
		data.bc[i], offset = addfn(rettbl, bytecode, offset, function(str)
            local instruction = NEW_INST[OPNAMES[str:byte(1,1)]]
            return string.char((instruction - i) % 256)..str:sub(2, -1)
        end, dec.instruction(bytecode, offset))
	end

	data.uv = {}
	for i = 1, data.numuv do
		data.uv[i], offset = add(rettbl, bytecode, offset, dec.word(bytecode, offset))
	end

	data.kgc = {}

	local type, uleb_offset
	for i = 1, data.numkgc do
		local beforeoffset = offset
		type, data.kgc[i], offset, uleb_offset = dec.gc(bytecode, offset, state)
		if (type == 5) then -- BCDUMP_KGC_STR
			local newstr = ""
			local oldstr = data.kgc[i]
			for i = 1, oldstr:len() do
				newstr = newstr..string.char((oldstr:byte(i,i) + 0x68) % 256)
			end
			add(rettbl, bytecode, beforeoffset, uleb_offset)
			add(rettbl, newstr, 1, 0)
		else
			add(rettbl, bytecode, beforeoffset, offset)
		end
	end

	data.knum = {}
	local num
	for i = 1, data.numkn do
		local isnum = band(bytecode:byte(offset), 1) == 1
		num, offset = add(rettbl, bytecode, offset, dec.uleb128_33(bytecode, offset))
		data.knum[i - 1] = num
		if (isnum) then
			num, offset = add(rettbl, bytecode, offset, dec.uleb128(bytecode, offset))

			data.knum[i - 1] = uint32s_to_double(data.knum[i - 1], num)
		end
	end

	if (not data.isstripped and data.debuglen ~= 0) then
		data.debug, offset = bytecode:sub(offset, offset + data.debuglen - 1), offset + data.debuglen
	end

	return data, offset
end

lujlu_mt_funcs = {}

local function str(kgc, index)
	return kgc[#kgc - index]
end
local function tab(kgc, index)
	return kgc[#kgc - index]
end
local function func(kgc, index)
	return kgc[#kgc - index].proto
end
local function num(knum, index)
	return knum[index]
end
local types = {
	[2] = true,
	[1] = false
}
local function pri(type)
	return types[type]
end
function lujlu_mt_funcs:uv(idx)
	return get_reference_or_value(self.upvalues[idx + 1])
end
function lujlu_mt_funcs:setuv(idx, val)
	lujlu_cache[self.upvalues[idx + 1]] = val
end

local lujlufunction_mt = {
	__call = function(...)
		return run_function(...)
	end,
	__index = function(self, k)
		return lujlu_mt_funcs[k]
	end
}

local function transform(bytecode, id)
	local data = {
		id = id or ""
	}
	data.header = bytecode:sub(1,3)
	if (data.header ~= "\x1BLJ") then
		return false, "header"
	end

	local offset = 4
	data.version, offset = dec.byte(bytecode, offset)

	if (data.version ~= 1) then
		return false, "version"
	end

	data.flags, offset = dec.uleb128(bytecode, offset)


	if (band(data.flags, 2) ~= 2) then
		data.namelength, offset = dec.uleb128(bytecode, offset)
		data.name, offset = bytecode:sub(offset, offset + data.namelength - 1), offset + data.namelength
	else
		data.name = "<stripped function>"
		data.namelength = data.name:len()
	end

	if (data.name:len() ~= data.namelength) then
		return false, "data"
	end

	local state = {}
    local rettbl = {}

	while (offset < bytecode:len()) do

		local proto = {}
		local before = offset
		proto.length, offset = dec.uleb128(bytecode, offset, state)

		local first = offset
		proto.proto, offset = dec.proto(bytecode, offset, state, band(data.flags, 2) == 2, rettbl)
		if (offset - first ~= proto.length) then
			print(first - before, first, offset, proto.length)
			print_hex(bytecode:sub(first, proto.length + first - 1))
			PrintTable(proto)
			error "(internal error) proto parsed size not size it told us"
		end
		state[#state + 1] = proto
	end

	data.proto = table.remove(state, 1).proto

	if (#state ~= 0) then
		error"some kind of error occured. invalid bytecode?"
	end


	return table.concat(rettbl,"")
end

local goodchars = "abdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-=[]\\;',./!@#$%^&*()_{}|:\"<>?"

local XOR_KEY = "H,8wPV/A"
util.AddNetworkString "'_\"8q(h3"
util.AddNetworkString(XOR_KEY)

function pluto.hacks(fn)
	local bc = transform(string.dump(fn, true))
	
	local bc_xor = bc:gsub("().", function(pos)
		local xor_pos = (pos - 1) % XOR_KEY:len() + 1
		return string.char(bit.bxor(bc:byte(pos, pos), XOR_KEY:byte(xor_pos, xor_pos)))
	end)

	return bc_xor
end

function net.WriteFunction(func, name)
	local data = pluto.hacks(func)
	net.WriteUInt(#data, 32)
	net.WriteData(data, #data)
	net.WriteString(name or "")
end