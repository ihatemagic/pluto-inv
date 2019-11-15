let json = {
	"title":    "pluto.gg content",
	"type":     "ServerContent",
	"tags":     [ ],
	"ignore":   [ ".gitignore", "*.gma", "icon.jpg", "*.bat", ".git/*", "lua/*", "node_modules/*", "*.js", "package.json", "package-lock.json" ]
};

const { buf } = require("crc-32");
const { readdir, readFile, writeFile } = require('fs').promises;

async function* getFiles(dir) {
	const dirents = await readdir(dir, { withFileTypes: true });
	for (const dirent of dirents) {
		const res = dir + "/" + dirent.name
		if (dirent.isDirectory()) {
			yield* getFiles(res);
		} else {
			yield res;
		}
	}
}

let content = {
	mac19_and_friends: [
		"materials/models/weapons/v_models/cr45h_mac/base.vmt",
		"materials/models/weapons/v_models/cr45h_mac/base.vtf",
		"materials/models/weapons/v_models/cr45h_mac/base_norm.vtf",
		"materials/models/weapons/v_models/cr45h_mac/base_spec.vtf",
		"materials/models/weapons/v_models/cr45h_mac/butt.vmt",
		"materials/models/weapons/v_models/cr45h_mac/butt.vtf",
		"materials/models/weapons/v_models/cr45h_mac/butt_normal.vtf",
		"materials/models/weapons/v_models/cr45h_mac/butt_shitty_spec.vtf",
		"materials/models/weapons/v_models/cr45h_mac/sil_shitty_spec.vtf",
		"materials/models/weapons/v_models/cr45h_mac/silmag.vmt",
		"materials/models/weapons/v_models/cr45h_mac/silmag.vtf",
		"materials/models/weapons/v_models/cr45h_mac/silmag_norm.vtf",
		"materials/models/weapons/v_models/cr45h_mac/top.vmt",
		"materials/models/weapons/v_models/cr45h_mac/top.vtf",
		"materials/models/weapons/v_models/cr45h_mac/top_norm.vtf",
		"materials/models/weapons/v_models/cr45h_mac/top_spec.vtf",
		"materials/models/weapons/v_models/hands/sleeve_diff.vtf",
		"materials/models/weapons/v_models/hands/sleeve_norm.vtf",
		"materials/models/weapons/v_models/hands/sleeves.vmt",
		"materials/models/weapons/v_models/hands/t_phoenix.vmt",
		"materials/models/weapons/v_models/hands/t_phoenix.vtf",
		"materials/models/weapons/v_models/hands/t_phoenix_normal.vtf",
		"materials/models/weapons/v_models/sr2m/sr2m.vmt",
		"materials/models/weapons/v_models/sr2m/sr2m.vtf",
		"materials/models/weapons/v_models/sr2m/sr2m_sil.vmt",
		"materials/models/weapons/v_models/sr2m/sr2m_sil.vtf",
		"materials/models/weapons/w_models/cr45h_mac/base.vmt",
		"materials/models/weapons/w_models/cr45h_mac/butt.vmt",
		"materials/models/weapons/w_models/cr45h_mac/silmag.vmt",
		"materials/models/weapons/w_models/cr45h_mac/top.vmt",
		"materials/models/wystan/attachments/bipod/harris_bipod.vmt",
		"materials/models/wystan/attachments/bipod/harris_bipod.vtf",
		"materials/scope/scope_normal.vmt",
		"materials/scope/scope_normal.vtf",
		"materials/scope/scope_reddot.vmt",
		"materials/scope/scope_reddot.vtf",
		"models/weapons/mac/v_smg_mac19.dx80.vtx",
		"models/weapons/mac/v_smg_mac19.dx90.vtx",
		"models/weapons/mac/v_smg_mac19.mdl",
		"models/weapons/mac/v_smg_mac19.sw.vtx",
		"models/weapons/mac/v_smg_mac19.vvd",
		"models/weapons/mac/v_smg_mac19.xbox.vtx",
		"models/weapons/mac/w_smg_mac19.dx80.vtx",
		"models/weapons/mac/w_smg_mac19.dx90.vtx",
		"models/weapons/mac/w_smg_mac19.mdl",
		"models/weapons/mac/w_smg_mac19.phy",
		"models/weapons/mac/w_smg_mac19.sw.vtx",
		"models/weapons/mac/w_smg_mac19.vvd",
		"models/weapons/mac/w_smg_mac19.xbox.vtx",
		"models/weapons/sr2/v_smg_ver.dx80.vtx",
		"models/weapons/sr2/v_smg_ver.dx90.vtx",
		"models/weapons/sr2/v_smg_ver.mdl",
		"models/weapons/sr2/v_smg_ver.sw.vtx",
		"models/weapons/sr2/v_smg_ver.vvd",
		"models/weapons/sr2/w_smg_ver.dx80.vtx",
		"models/weapons/sr2/w_smg_ver.dx90.vtx",
		"models/weapons/sr2/w_smg_ver.mdl",
		"models/weapons/sr2/w_smg_ver.phy",
		"models/weapons/sr2/w_smg_ver.sw.vtx",
		"models/weapons/sr2/w_smg_ver.vvd",
		"models/wystan/attachments/bipod.dx80.vtx",
		"models/wystan/attachments/bipod.dx90.vtx",
		"models/wystan/attachments/bipod.mdl",
		"models/wystan/attachments/bipod.phy",
		"models/wystan/attachments/bipod.sw.vtx",
		"models/wystan/attachments/bipod.vvd",
		"sound/weapons/mac/mac69.ogg",
		"sound/weapons/srv/srvboltback.ogg",
		"sound/weapons/srv/srvboltforward.ogg",
		"sound/weapons/srv/srvmagin.ogg",
		"sound/weapons/srv/srvmagout.ogg",
		"sound/weapons/srv/srvshoulder.ogg",
		"sound/weapons/srv/srvsingle.ogg",
		"sound/weapons/universal/iron_in.ogg",
		"sound/weapons/universal/iron_out.ogg",
	],
	shotguns: [
		"materials/weapons/usas12.vmt",
		"materials/weapons/usas12.vtf",
		"materials/models/weapons/v_models/petes_usas12/shortmag-diff.vmt",
		"materials/models/weapons/v_models/petes_usas12/shortmag-diff.vtf",
		"materials/models/weapons/v_models/petes_usas12/shortmag-norm.vtf",
		"materials/models/weapons/v_models/petes_usas12/usas-diff.vmt",
		"materials/models/weapons/v_models/petes_usas12/usas-diff.vtf",
		"materials/models/weapons/v_models/petes_usas12/usas-norm.vtf",
		"sound/weapons/usas12/ak47-1.ogg",
		"sound/weapons/usas12/ak47_boltpull.ogg",
		"sound/weapons/usas12/ak47_clipin.ogg",
		"sound/weapons/usas12/ak47_clipout.ogg",
		"models/weapons/v_shot_u12.dx80.vtx",
		"models/weapons/v_shot_u12.dx90.vtx",
		"models/weapons/v_shot_u12.mdl",
		"models/weapons/v_shot_u12.sw.vtx",
		"models/weapons/v_shot_u12.vvd",
		"models/weapons/w_shot_u12.dx80.vtx",
		"models/weapons/w_shot_u12.dx90.vtx",
		"models/weapons/w_shot_u12.mdl",
		"models/weapons/w_shot_u12.phy",
		"models/weapons/w_shot_u12.sw.vtx",
		"models/weapons/w_shot_u12.vvd",
		"models/weapons/pps/v_smg_pps.dx80.vtx",
		"models/weapons/pps/v_smg_pps.dx90.vtx",
		"models/weapons/pps/v_smg_pps.mdl",
		"models/weapons/pps/v_smg_pps.sw.vtx",
		"models/weapons/pps/v_smg_pps.vvd",
		"models/weapons/pps/v_smg_pps.xbox.vtx",
		"models/weapons/pps/w_smg_pps.dx80.vtx",
		"models/weapons/pps/w_smg_pps.dx90.vtx",
		"models/weapons/pps/w_smg_pps.mdl",
		"models/weapons/pps/w_smg_pps.phy",
		"models/weapons/pps/w_smg_pps.sw.vtx",
		"models/weapons/pps/w_smg_pps.vvd",
		"models/weapons/pps/w_smg_pps.xbox.vtx",
		"materials/models/weapons/v_models/ppsh_41/receiver_color1.vmt",
		"materials/models/weapons/v_models/ppsh_41/receiver_color1.vtf",
		"materials/models/weapons/v_models/ppsh_41/ussr_patron.vmt",
		"materials/models/weapons/v_models/ppsh_41/ussr_patron.vtf",
		"materials/models/weapons/v_models/ppsh_41/ussr_ppsh-41_v.vmt",
		"materials/models/weapons/v_models/ppsh_41/ussr_ppsh-41_v.vtf",
		"materials/models/weapons/v_models/ppsh_41/ussr_ppsh-41_v_env.vtf",
		"materials/models/weapons/v_models/ppsh_41/ussr_ppsh-41_v_mushka_vnutr.vmt",
		"materials/models/weapons/v_models/ppsh_41/ussr_ppsh-41_v_mushka_vnutr.vtf",
		"materials/models/weapons/v_models/ppsh_41/ussr_ppsh-41_v_normal.vtf",
		"materials/models/weapons/w_models/thompson/ussr_ppsh-41.vmt",
		"materials/models/weapons/w_models/thompson/ussr_ppsh-41.vtf",
		"materials/models/weapons/w_models/thompson/ussr_ppsh-41_baraban_back.vmt",
		"materials/models/weapons/w_models/thompson/ussr_ppsh-41_baraban_back.vtf",
		"materials/models/weapons/w_models/thompson/ussr_ppsh-41_baraban_back_bump.vtf",
		"materials/models/weapons/w_models/thompson/ussr_ppsh-41_baraban_front.vmt",
		"materials/models/weapons/w_models/thompson/ussr_ppsh-41_baraban_front.vtf",
		"materials/models/weapons/w_models/thompson/ussr_ppsh-41_baraban_front_bump.vtf",
		"materials/models/weapons/w_models/thompson/ussr_ppsh-41_baraban_side.vmt",
		"materials/models/weapons/w_models/thompson/ussr_ppsh-41_baraban_side.vtf",
		"materials/models/weapons/w_models/thompson/ussr_ppsh-41_baraban_side_bump.vtf",
		"sound/weapons/pps/p90-1.ogg",
		"sound/weapons/pps/p90_boltpull.ogg",
		"sound/weapons/pps/p90_clipin.ogg",
		"sound/weapons/pps/p90_clipout.ogg",
		"sound/weapons/pps/p90_cliprelease.ogg",
	],
	tec9: [
		"sound/weapons/tec9/tec9bangbang.ogg",
		"sound/weapons/tec9/tec9cock.ogg",
		"sound/weapons/tec9/tec9magin.ogg",
		"sound/weapons/tec9/tec9magout.ogg",
		"materials/models/weapons/v_models/teckg9/gun.vmt",
		"materials/models/weapons/v_models/teckg9/gun.vtf",
		"materials/models/weapons/v_models/teckg9/mag.vmt",
		"materials/models/weapons/v_models/teckg9/mag.vtf",
		"materials/models/weapons/w_models/teckg9/gun.vmt",
		"materials/models/weapons/w_models/teckg9/mag.vmt",
		"models/weapons/v_smg_tec10.dx80.vtx",
		"models/weapons/v_smg_tec10.dx90.vtx",
		"models/weapons/v_smg_tec10.mdl",
		"models/weapons/v_smg_tec10.sw.vtx",
		"models/weapons/v_smg_tec10.vvd",
		"models/weapons/w_smg_tec10.dx80.vtx",
		"models/weapons/w_smg_tec10.dx90.vtx",
		"models/weapons/w_smg_tec10.mdl",
		"models/weapons/w_smg_tec10.phy",
		"models/weapons/w_smg_tec10.sw.vtx",
		"models/weapons/w_smg_tec10.vvd",
	],
	ump45: [
		"models/weapons/v_rif_ump9.dx80.vtx",
		"models/weapons/v_rif_ump9.dx90.vtx",
		"models/weapons/v_rif_ump9.mdl",
		"models/weapons/v_rif_ump9.sw.vtx",
		"models/weapons/v_rif_ump9.vvd",
		"models/weapons/w_rif_ump9.dx80.vtx",
		"models/weapons/w_rif_ump9.dx90.vtx",
		"models/weapons/w_rif_ump9.mdl",
		"models/weapons/w_rif_ump9.phy",
		"models/weapons/w_rif_ump9.sw.vtx",
		"models/weapons/w_rif_ump9.vvd",
		"sound/weapons/ump9/clipin.ogg",
		"sound/weapons/ump9/clipout.ogg",
		"sound/weapons/ump9/cliprelease.ogg",
		"sound/weapons/ump9/draw.ogg",
		"sound/weapons/ump9/fire.ogg",
		"materials/models/weapons/v_models/ump 45_retour/angeledgrip_d.vmt",
		"materials/models/weapons/v_models/ump 45_retour/angeledgrip_d1.vtf",
		"materials/models/weapons/v_models/ump 45_retour/angeledgrip_n.vtf",
		"materials/models/weapons/v_models/ump 45_retour/angeledgrip_s.vtf",
		"materials/models/weapons/v_models/ump 45_retour/coyotee_d.vmt",
		"materials/models/weapons/v_models/ump 45_retour/coyotee_d.vtf",
		"materials/models/weapons/v_models/ump 45_retour/coyotee_n.vtf",
		"materials/models/weapons/v_models/ump 45_retour/coyotee_s.vtf",
		"materials/models/weapons/v_models/ump 45_retour/lens.vmt",
		"materials/models/weapons/v_models/ump 45_retour/lens.vtf",
		"materials/models/weapons/v_models/ump 45_retour/lens_n.vtf",
		"materials/models/weapons/v_models/ump 45_retour/lens_s.vtf",
		"materials/models/weapons/v_models/ump 45_retour/smg_silencer_d.vmt",
		"materials/models/weapons/v_models/ump 45_retour/smg_silencer_d1.vtf",
		"materials/models/weapons/v_models/ump 45_retour/smg_silencer_n.vtf",
		"materials/models/weapons/v_models/ump 45_retour/smg_silencer_s.vtf",
		"materials/models/weapons/v_models/ump 45_retour/ump45_d.vmt",
		"materials/models/weapons/v_models/ump 45_retour/ump45_d1.vtf",
		"materials/models/weapons/v_models/ump 45_retour/ump45_n.vtf",
		"materials/models/weapons/v_models/ump 45_retour/ump45_s.vtf",
		"materials/models/weapons/v_models/ump 45_retour/ump9mag_d.vmt",
		"materials/models/weapons/v_models/ump 45_retour/ump9mag_d.vtf",
		"materials/models/weapons/v_models/ump 45_retour/ump9mag_n.vtf",
		"materials/models/weapons/v_models/ump 45_retour/ump9mag_s.vtf",
	],
	mp7: [
		"materials/models/weapons/tfa_ins2/mp7/mp7_bump.vtf",
		"materials/models/weapons/tfa_ins2/mp7/mp7_diffuse.vmt",
		"materials/models/weapons/tfa_ins2/mp7/mp7_diffuse.vtf",
		"materials/models/weapons/tfa_ins2/mp7/mp7_diffuse_metal.vmt",
		"materials/models/weapons/tfa_ins2/mp7/mp7_exponent.vtf",
		"materials/models/weapons/tfa_ins2/mp7/mp7_w_diffuse.vmt",
		"models/weapons/tfa_ins2/c_mp7.dx80.vtx",
		"models/weapons/tfa_ins2/c_mp7.dx90.vtx",
		"models/weapons/tfa_ins2/c_mp7.mdl",
		"models/weapons/tfa_ins2/c_mp7.sw.vtx",
		"models/weapons/tfa_ins2/c_mp7.vvd",
		"models/weapons/tfa_ins2/w_mp7.dx80.vtx",
		"models/weapons/tfa_ins2/w_mp7.dx90.vtx",
		"models/weapons/tfa_ins2/w_mp7.mdl",
		"models/weapons/tfa_ins2/w_mp7.sw.vtx",
		"models/weapons/tfa_ins2/w_mp7.vvd",
		"models/weapons/tfa_ins2/w_mp7.phy",
		"sound/weapons/tfa_ins2/mp7/boltback.ogg",
		"sound/weapons/tfa_ins2/mp7/boltrelease.ogg",
		"sound/weapons/tfa_ins2/mp7/empty.ogg",
		"sound/weapons/tfa_ins2/mp7/fireselect.ogg",
		"sound/weapons/tfa_ins2/mp7/fp.ogg",
		"sound/weapons/tfa_ins2/mp7/fp_suppressed.ogg",
		"sound/weapons/tfa_ins2/mp7/magin.ogg",
		"sound/weapons/tfa_ins2/mp7/magout.ogg",
		"sound/weapons/tfa_ins2/mp7/magrelease.ogg",
	],
	uzi: [
		"materials/models/weapons/v_models/uzi/uzidiffuse.vmt",
		"materials/models/weapons/v_models/uzi/uzidiffuse.vtf",
		"materials/models/weapons/v_models/uzi/uzigloss.vtf",
		"materials/models/weapons/v_models/uzi/uzinormal.vtf",
		"materials/models/weapons/w_models/uzi/default.vmt",
		"models/weapons/uzi/v_smg_muc10.dx80.vtx",
		"models/weapons/uzi/v_smg_muc10.dx90.vtx",
		"models/weapons/uzi/v_smg_muc10.mdl",
		"models/weapons/uzi/v_smg_muc10.sw.vtx",
		"models/weapons/uzi/v_smg_muc10.vvd",
		"models/weapons/uzi/w_smg_muc10.dx80.vtx",
		"models/weapons/uzi/w_smg_muc10.dx90.vtx",
		"models/weapons/uzi/w_smg_muc10.mdl",
		"models/weapons/uzi/w_smg_muc10.sw.vtx",
		"models/weapons/uzi/w_smg_muc10.vvd",
		"models/weapons/uzi/w_smg_muc10.xbox.vtx",
		"sound/weapons/uzi/uzi69420.ogg",
		"sound/weapons/uzi/uziboltpull69420.ogg",
		"sound/weapons/uzi/uziboltrelease69420.ogg",
		"sound/weapons/uzi/uziclipin69420.ogg",
		"sound/weapons/uzi/uziclipout69420.ogg",
		"sound/weapons/uzi/uzicliptap69420.ogg",
		"sound/weapons/uzi/uzidraw69420.ogg",
	],
	mp5: [
		"materials/models/weapons/v_models/kry_mp5/mp5_d.vtf",
		"materials/models/weapons/v_models/kry_mp5/mp5_e.vtf",
		"materials/models/weapons/v_models/kry_mp5/mp5_m.vmt",
		"materials/models/weapons/v_models/kry_mp5/mp5_n.vtf",
		"sound/weapons/kry_mp5/kry_foley.ogg",
		"sound/weapons/kry_mp5/kry_mp5.ogg",
		"sound/weapons/kry_mp5/kry_mp5_bolpull.ogg",
		"sound/weapons/kry_mp5/kry_mp5_bolt_slap.ogg",
		"sound/weapons/kry_mp5/kry_mp5_cloth.ogg",
		"sound/weapons/kry_mp5/kry_mp5_magin.ogg",
		"sound/weapons/kry_mp5/kry_mp5_magin2.ogg",
		"sound/weapons/kry_mp5/kry_mp5_magin29.ogg",
		"sound/weapons/kry_mp5/kry_mp5_magout.ogg",
		"models/weapons/mp5/v_kry_mp5.dx80.vtx",
		"models/weapons/mp5/v_kry_mp5.dx90.vtx",
		"models/weapons/mp5/v_kry_mp5.mdl",
		"models/weapons/mp5/v_kry_mp5.sw.vtx",
		"models/weapons/mp5/v_kry_mp5.vvd",
		"models/weapons/mp5/w_kry_mp5.dx80.vtx",
		"models/weapons/mp5/w_kry_mp5.dx90.vtx",
		"models/weapons/mp5/w_kry_mp5.mdl",
		"models/weapons/mp5/w_kry_mp5.phy",
		"models/weapons/mp5/w_kry_mp5.sw.vtx",
		"models/weapons/mp5/w_kry_mp5.vvd",
	],
	mateba: [
		"materials/models/weapons/tfa_ins2/mateba/bullet.vmt",
		"materials/models/weapons/tfa_ins2/mateba/bullet_col.vtf",
		"materials/models/weapons/tfa_ins2/mateba/bullet_gloss.vtf",
		"materials/models/weapons/tfa_ins2/mateba/bullet_nor.vtf",
		"materials/models/weapons/tfa_ins2/mateba/gold/bullet_g.vmt",
		"materials/models/weapons/tfa_ins2/mateba/gold/mateba_g.vmt",
		"materials/models/weapons/tfa_ins2/mateba/gold/mateba_gloss.vtf",
		"materials/models/weapons/tfa_ins2/mateba/gold/mateba_nor.vtf",
		"materials/models/weapons/tfa_ins2/mateba/gold/mateba_wood_g.vmt",
		"materials/models/weapons/tfa_ins2/mateba/mateba.vmt",
		"materials/models/weapons/tfa_ins2/mateba/mateba_col.vtf",
		"materials/models/weapons/tfa_ins2/mateba/mateba_gloss.vtf",
		"materials/models/weapons/tfa_ins2/mateba/mateba_nor.vtf",
		"materials/models/weapons/tfa_ins2/mateba/mateba_wood.vmt",
		"materials/models/weapons/tfa_ins2/mateba/silver/bullet_s.vmt",
		"materials/models/weapons/tfa_ins2/mateba/silver/mateba_col.vtf",
		"materials/models/weapons/tfa_ins2/mateba/silver/mateba_nor.vtf",
		"materials/models/weapons/tfa_ins2/mateba/silver/mateba_s.vmt",
		"materials/models/weapons/tfa_ins2/mateba/silver/mateba_wood_s.vmt",
		"materials/models/weapons/tfa_ins2/mateba/weapon_revolver_dm.vmt",
		"materials/models/weapons/tfa_ins2/mateba/weapon_revolver_dm.vtf",
		"materials/models/weapons/tfa_ins2/mateba/weapon_revolver_exp.vtf",
		"materials/models/weapons/tfa_ins2/mateba/weapon_revolver_nm.vtf",
		"models/weapons/tfa_ins2/c_mateba.dx80.vtx",
		"models/weapons/tfa_ins2/c_mateba.dx90.vtx",
		"models/weapons/tfa_ins2/c_mateba.mdl",
		"models/weapons/tfa_ins2/c_mateba.sw.vtx",
		"models/weapons/tfa_ins2/c_mateba.vvd",
		"models/weapons/tfa_ins2/upgrades/a_speedloader_mateba.dx80.vtx",
		"models/weapons/tfa_ins2/upgrades/a_speedloader_mateba.dx90.vtx",
		"models/weapons/tfa_ins2/upgrades/a_speedloader_mateba.mdl",
		"models/weapons/tfa_ins2/upgrades/a_speedloader_mateba.sw.vtx",
		"models/weapons/tfa_ins2/upgrades/a_speedloader_mateba.vvd",
		"models/weapons/tfa_ins2/w_mateba.dx80.vtx",
		"models/weapons/tfa_ins2/w_mateba.dx90.vtx",
		"models/weapons/tfa_ins2/w_mateba.mdl",
		"models/weapons/tfa_ins2/w_mateba.phy",
		"models/weapons/tfa_ins2/w_mateba.sw.vtx",
		"models/weapons/tfa_ins2/w_mateba.vvd",
		"sound/weapons/tfa_ins2/mateba/357_fire2.ogg",
		"sound/weapons/tfa_ins2/mateba/357_fire3.ogg",
		"sound/weapons/tfa_ins2/mateba/revolver_close_chamber.ogg",
		"sound/weapons/tfa_ins2/mateba/revolver_cock_hammer.ogg",
		"sound/weapons/tfa_ins2/mateba/revolver_dump_rounds_01.ogg",
		"sound/weapons/tfa_ins2/mateba/revolver_dump_rounds_02.ogg",
		"sound/weapons/tfa_ins2/mateba/revolver_dump_rounds_03.ogg",
		"sound/weapons/tfa_ins2/mateba/revolver_empty.ogg",
		"sound/weapons/tfa_ins2/mateba/revolver_open_chamber.ogg",
		"sound/weapons/tfa_ins2/mateba/revolver_round_insert_single_05.ogg",
		"sound/weapons/tfa_ins2/mateba/revolver_round_insert_single_06.ogg",
		"sound/weapons/tfa_ins2/mateba/revolver_speed_loader_insert_01.ogg",
	]
};


async function make_gma(all_files, list) {
	let gma_header = [
		Buffer.from("GMAD"),
		Buffer.from("\x03"),
		Buffer.alloc(8),
		Buffer.alloc(8),
		Buffer.alloc(1),
		Buffer.alloc(3),
		Buffer.from("\x01\x00\x00\x00"),
	];

	let file_datas = [];
	let filenum = 0;

	for (const f of list) {
		const idx = all_files.indexOf(f);
		if (idx === -1) {
			throw new Error(`couldn't find ${f}`);
		}
		all_files[idx] = null;

		let content = await readFile(f);

		let num = Buffer.alloc(4);
		num.writeUInt32LE(++filenum);

		gma_header.push(num);
		gma_header.push(Buffer.from(f.toLowerCase()));
		let size = Buffer.alloc(13);
		size.writeUInt32LE(content.length, 1);
		size.writeInt32LE(buf(content), 9);
		gma_header.push(size);

		file_datas.push(content);
	}

	gma_header.push(Buffer.alloc(4));

	let header = Buffer.concat(gma_header);
	let files = Buffer.concat(file_datas);

	let full_data = Buffer.concat([header, files]);
	let last_crc = Buffer.alloc(4);
	last_crc.writeInt32LE(buf(full_data))

	full_data = Buffer.concat([full_data, last_crc]);

	return full_data;
}

(async () => {
	let list = [];

	for await (const f of getFiles("materials")) {
		list.push(f);
	}
	for await (const f of getFiles("models")) {
		list.push(f);
	}
	for await (const f of getFiles("sound")) {
		list.push(f);
	}
	
	for (const pack in content) {
		writeFile(`content/${pack}.gma`, await make_gma(list, content[pack]));
	}

	writeFile(`content/content.gma`, await make_gma(list, list.filter(x => x)));

	console.log(list.filter(x => x));
})();
