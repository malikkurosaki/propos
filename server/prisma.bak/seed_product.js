const { PrismaClient } = require("@prisma/client")
const prisma = new PrismaClient();
const uuid = require("uuid");

const listBreakfast = [
    {
        "image": "https://cf.shopee.co.id/file/ca21df4f9a3bce25d7469e573d05337f_tn",
        "name": "Abon ayam karwati",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/214ff7b200f3b2903498b5f8163968df_tn",
        "name": "Fitbar 22 gr All Variant",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/4a6d7087cbf6d98def24608bbceb8c44_tn",
        "name": "FITBAR 22 gr  all varian",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/a3b85ca756bc3e92b32a62c2548dd619_tn",
        "name": "MAKARONI BANTET TASIKMALAYA",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/293325398a904492dfcdacf1e8fcedff_tn",
        "name": "MamaSuka - Rumput Laut Panggang Isi 4 @4,5 gr",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/4f094e348cbfcaf37c7a671f5683f5d6_tn",
        "name": "Basreng 250 gram (Baso Goreng)",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/cfeda035cd5058da45388e42670dd3ad_tn",
        "name": "(PROMO) Manjun Nori HALAL Seaweed Rumput Laut Sushi Gimbap Korean Yaki Sushi Nori",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/635d83014123689943591b38ae0371e1_tn",
        "name": "SUKARI PREMIUM 1 KG Kemasan Dus (Expired 2023)  / Kurma Sukari Kurma Raja Kurma Sukkari 100% Asli Original KEMASAN DUS",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/65a431d8f3a27142169b1b977638fc0c_tn",
        "name": "Makaroni Bantet/Bantat termurah khas Tasikmalaya",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/b40bbf1a78bc6ca68e91064e9a38806b_tn",
        "name": "[PROMO!!] Duosus soes coklat / blueberry / mystar mini nikmat 35 gram - cemilan sus enak termurah",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/779683a75f19c16f8218130f6329c614_tn",
        "name": "Kurma Ajwa 1 KG Asli Madinah ( EXP 2023 )/ Kurma Nabi Ajwa Premium Original Saudi Arabia",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/e78048b8f2d3084b677504d0be0ebf89_tn",
        "name": "MAKARONI BANTET CAP KOKI  TIDAK MENERIMA ECER DI BAWAH 10PCS",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/dfee5ea06ecd6d52adfe8e7fd0b8b76c_tn",
        "name": "MAKARONI BANTET TASIKMALAYA CAP KOKI - MAKARONI BANTET PEDAS - KRIWIL BANTET",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/0a69c1d586bacfe83ce30a4e8c1be61c_tn",
        "name": "Kurma SUKARI Ember Al-Qossim 850 GR/ Sukkari Ember Kurma Raja Premium Kualitas 100% SUPER PREMIUM",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/c49718a48ff6c2788671328a706d6f5e_tn",
        "name": "(TERMURAH) MAKARONI Bantet/bantat -khas mojokerto",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/7b764076ac54c4870b55d29cba246547_tn",
        "name": "Kurma Ajwa 1 Kg Asli / Kurma Nabi Super Asli Madinah",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/9a482919b95c3c818990fa76220461ae_tn",
        "name": "Makaroni Spiral Balado BBQ Super Pedas 36g",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/5647a4b12a180fb91ff8e5fadfdec51f_tn",
        "name": "Slim & Fit Cookies Snack Diet Low Calori - Netto 22 gr",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/60ff089fe068d725ba4de6cbfe332e9c_tn",
        "name": "BASRENG 100gr / BAKSO GORENG / BASO GORENG NGABRET",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/b2ecd568624a296a71b36226ca079b7a_tn",
        "name": "Royco sapi sachet 9gr",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/1f0fec424f15f8c6440ecad36830c2be_tn",
        "name": "KACANG MEDE ANEKA RASA 500gr",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/244824ea61d8fb2289f06660ac1fff5c_tn",
        "name": "[TERMURAH] MAKARONI BANTET-Bantat Khas TASIKMALAYA COD",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/a6c035db27125f77266beaf6c10fc383_tn",
        "name": "Mie lidi murah 45gr",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/f8384f1242ca4f8dd275cbe0030ccc64_tn",
        "name": "Milo cube milo kotak milo mini isi 1pcs 50pcs 100pcs Milo cube 100pcs",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/e8c79269c1fd34a0bccb40de348fe6cc_tn",
        "name": "Basreng stik Bumbu Basah Daun jeruk/Basreng pedas 100 gram",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/bcf7139d80f5c8ee3c77ec248272c850_tn",
        "name": "MIE LIDI SI UMANG 130gr PANJANG 30CM KEMASAN KERTAS/ LIDI SI UMANG",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/3620aca3935a38c205f39f8d8e50ae23_tn",
        "name": "JollyTime PopCorn - Mix n Match. Jolly Time PopCorn Product Of USA",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/80e09fdf53d431db7101c73c5e77a23d_tn",
        "name": "Mie Lidi Kemasan 40Gram  Uwa Snack",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/e0bbc253c7ace7f6fe739d6a74baf9b6_tn",
        "name": "Basreng pedas daun jeruk isi 500gram",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/1e1cc8ed27b6b480433bd33f264c5792_tn",
        "name": "KACANG ALMOND PANGGANG KUPAS 1KG (ROASTED)",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/1b049958b2dad65060e0d8d5a7b7c06e_tn",
        "name": "KACANG ALMOND PANGGANG PREMIUM 500gr (Roasted)",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/fa2e493306b3bc9649a8d680069c5d04_tn",
        "name": "Kurma Sukari 850 gr KEMASAN EMBER (Ruthob) Kurma Basah 850gr",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/9f104071097aa25d16d80775dc624b7f_tn",
        "name": "CANNON BALL COKLAT KUNYAH COKELAT // 1 PCS",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/a0f3619b916f0ade622bf829a84b09c4_tn",
        "name": "Permen Madu Isi Somboy Bon Bon Somboi Kiamboy Kiamboi Naraya Plum Candy Cemilan Jadul Murah Bonbon",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/af91b6a1b009bb6211f84b1246591e8a_tn",
        "name": "Kurma Sukari Ember 850 Gr Premium Dates - Ajwa Madina Ember Premium 850gr Original Kurma Sukari Ember Murni Sukari Timbah Kurma Tunisia Ember 850 gram Kurma Barari Ember 850 gr Kurma Tunisia Madu 850 gr",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/1806a839b1c599e33fef63d24f3094bd_tn",
        "name": "Silverqueen Mete 62gr/65gr /65gram / 65/62/62gram",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/cd704a80f70cc88dcdfb29ca10dabb30_tn",
        "name": "BISKITOP - VEGETABLE STICK 60g Biskuit Anak Dewasa Enak Renyah Biscuit Stik Rasa Sayuran Keju",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/db2d84ea1e41ae6be34a89c0d2adb9cc_tn",
        "name": "BASO ACI ABAH TEA BASO ACI TULANG RANGU PEDAS TERLEZAT CUANKI INSTAN TOPING BASO ACI TOPING BOCI SIOMAY KERING  BAKSO ACI TULANG RANGU ABAH TEA TERMURAH",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/ce6e84e79375c56ab9d85a3cd4451843_tn",
        "name": "KERUPUK KEMPLANG PANGGANG ASLI PALEMBANG MAKANAN KHAS PALEMBANG TERMURAH / KERUPUK KEMPLANG TUNU",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/8d8b334c8c242abadd0f05477f75761d_tn",
        "name": "Basreng 100 gram (Baso Goreng)",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/3d731428fb4a59a10f17ae901979e928_tn",
        "name": "JennToys - Makanan anak Pudding puding jelly - INACO MINI JELLY 5pc",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/3f14b2fb535c50761207ad96d7b8e7f8_tn",
        "name": "MIE LIDI 40gr / MIE LIDI PEDAS / MIE LIDI NGABRET BANYAK RASA / MIE LIDI BANDUNG",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/79fe23313191e55b0e8b18f0d5c6b241_tn",
        "name": "BABY CRAB KRISPY HALAL!!! 100 gr | BABY RAJUNGAN  | KEPITING KRIUK | CAMILAN | SEAFOOD |CRAB KRIPS",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/64d3e911b02346a0209f070910b9bb69_tn",
        "name": "Mie lidi paket reseller kemasan 45 gram",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/78935e310c5c086ff488e2fc503fb55e_tn",
        "name": "KERUPUK SEBLAK BANTET KRUPUKBAWANG ASLIMOJOKERTO-netto70Gram",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/941a4bd3897433891de7c7ac2d7eaa24_tn",
        "name": "Pocky Wafer Stick - Netto 22 gr",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/582ee3f4ee7961de0e7ad68c22b09b5b_tn",
        "name": "[Terlaris] Dendeng Sapi WT Asli Boyolali - Original Beef",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/d2b93c6413139a063492ad9004529c64_tn",
        "name": "MAKARONI BANTET Tasikmalaya Cap Koki Best Seller",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/6351d1ff9d7ed8003f55870df18e0aa5_tn",
        "name": "Permen Alba Pastilles 100 gr",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/555c40e73e3859b59991f3518383c6d0_tn",
        "name": "Permen Lolipop 6,5-7 Cm SPIRAL LOVE BULAT",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/60549b005c58f66739f332165e996415_tn",
        "name": "[PROMO!!] Pocky Mini 22gram - snack cemilan pocky coklat strawberry nikmat termurah",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/54a0b646393fcde50201c34bc79690e9_tn",
        "name": "POPCORN / POPCORN PEDAS / CEMILAN JAGUNG",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/15a6c6d5f47b5e2ac8c31c35008a2f95_tn",
        "name": "Dried Cut Wakame - Rumput Laut Kering - Untuk Ramen Udon Miso 25 Gr",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/4fc0ae51648fb8f00b668b018d2922a2_tn",
        "name": "Basreng pedas daun jeruk baso goreng kripik basreng 100gram",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/04f293a832e25c78e7920092f5110838_tn",
        "name": "JennToys - Nabati Richeese Biskuit Keju Coklat Richeese Nabati Regular - NABATI WAFER 50gr",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/b7998ace0f2a94fec57714c37d9cd605_tn",
        "name": "Makaroni Spiral Kemasan 40gram Uwa Snack",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/5ff7795b5db202fba3c4a35b49c4390b_tn",
        "name": "Kacang Mede Oven Panggang Roasted Mete Jumbo 100~200 Gr",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/617df296fb6a906e8551e8e84de9612a_tn",
        "name": "(TERMURAH)krupuk SEBLAK bantet- khas mojokerto",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/9510699c6d62081b1d913d686cc56413_tn",
        "name": "Makaroni Bantet/Bantat termurah bisa COD",
        "price": 10000,
        
    },
    {
        "image": "https://cf.shopee.co.id/file/43cea4bfb05c4c835ee84a271cbc5911_tn",
        "name": "GRANDVILLE ABON SAPI AYAM ASLI CRUNCHY | MPASI MAKANAN INSTAN SNACK",
        "price": 10000,
        
    }
]

async function SeedBreactfast(){
    let id = 1;
    for (let breakfast of listBreakfast){
        await prisma.products.upsert({
            where: {
                id: id.toString()
            },
            create: {
                id: id.toString(),
                name: breakfast.name.substring(0,20),
                price: breakfast.price + id,
                description: "breakfast.description",
                categoriesId: "1",
                usersId: "1",
                Images: {
                    create: {
                        url: breakfast.image
                    },
                }
            },
            update: {
                name: breakfast.name,
                price: breakfast.price,
                description: "breakfast.description",
            }
        })
        id++;
    }

    console.log("Seed Product Success")
}

module.exports = {SeedBreactfast}