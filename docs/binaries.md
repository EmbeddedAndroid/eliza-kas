# Prebuilt inputs

Every prebuilt binary the images take, from the pinned meta-qcom recipes
(generated with `tools/binaries.py <meta-qcom> <recipe prefixes>`). Bitbake
refuses a download whose sha256 differs. Config #1 uses the boot binaries,
the CDT and the Hexagon DSP binaries (git, pinned by SRCREV); config #2
adds the rest. The camx packages of other SoCs are pulled in by
qcom-multimedia-proprietary-image itself; Eliza has no camx package.

A builder who keeps these files in a local mirror sets it in
`kas/local/mirror.yml` (from `kas/templates/mirror.yml.in`).

| recipe | version | SRC_URI name | sha256 | recipe file |
|---|---|---|---|---|
| camxcommon-headers | 1.0.56 | - | `0b96cccab66fc1b4f0aeddb947c59fa9bc8f5044abf86cd7c6a7056e40da787a` | recipes-multimedia/camx/camxcommon-headers_1.0.56.bb |
| camxfirmware-hamoa | 1.0.6 | - | `21c27f927c8a8d5caa97ae70a49fa57d513c8c6b9232fba2dc0503f6b7fd0fac` | recipes-bsp/firmware/camxfirmware-hamoa_1.0.6.bb |
| camxfirmware-kodiak | 1.0.7 | - | `e346b7b5b20e8f28e2dc5cf36edc52f25eb3aeab315f77999c55c6dc1b2efbe6` | recipes-bsp/firmware/camxfirmware-kodiak_1.0.7.bb |
| camxfirmware-lemans | 1.0.7 | - | `62dd76046c1ae0e34f843285524be02e9fe96093ff68096cb998e9844f729f9d` | recipes-bsp/firmware/camxfirmware-lemans_1.0.7.bb |
| camxfirmware-nord | 1.0.8 | - | `6474371fffa7019f69e5547b4008fcc4164cdae88dcedc4a59f10a698357e3e4` | recipes-bsp/firmware/camxfirmware-nord_1.0.8.bb |
| camxfirmware-talos | 1.0.1 | - | `b9f9e36ab2a81cc4b5583110776b45a281f63acb9974a09bee19735b6daaa0df` | recipes-bsp/firmware/camxfirmware-talos_1.0.1.bb |
| camxlib-hamoa | 1.0.56 | camx | `3d52d35a389c3bde2b5303da646e0df9af9dab8252ad40bf46bababa814e43dd` | dynamic-layers/openembedded-layer/recipes-multimedia/camx/camxlib-hamoa_1.0.56.bb |
| camxlib-hamoa | 1.0.56 | camxcommon | `689f8103629afc8b16259216d5d069e21d5b4f995fa1773e3a316484cbd39323` | dynamic-layers/openembedded-layer/recipes-multimedia/camx/camxlib-hamoa_1.0.56.bb |
| camxlib-hamoa | 1.0.56 | camxlib | `69cc0eb533e0c496b354a9ca5569cf9645fa72d914145af2a1b08e6aaa48592f` | dynamic-layers/openembedded-layer/recipes-multimedia/camx/camxlib-hamoa_1.0.56.bb |
| camxlib-hamoa | 1.0.56 | camxtest | `8c274e1d9f6f6db58a1cdc7bddfc6c886f6ae4d5cc61c91af1fa9710b4992c8e` | dynamic-layers/openembedded-layer/recipes-multimedia/camx/camxlib-hamoa_1.0.56.bb |
| camxlib-hamoa | 1.0.56 | chicdk | `9517bd512242d731fc1a79b1be047658edb31cc6c653c72386732923447e8dd1` | dynamic-layers/openembedded-layer/recipes-multimedia/camx/camxlib-hamoa_1.0.56.bb |
| camxlib-kodiak | 1.0.52 | camx | `b78d3dc3cd8cb990c9ed4852077a0885f22c68849032ebc40fdcfb82c3608102` | dynamic-layers/openembedded-layer/recipes-multimedia/camx/camxlib-kodiak_1.0.52.bb |
| camxlib-kodiak | 1.0.52 | camxlib | `f093d2fcfb222bcef6874d67df19afb48f25101012e5fc9b661a80eb73e9448f` | dynamic-layers/openembedded-layer/recipes-multimedia/camx/camxlib-kodiak_1.0.52.bb |
| camxlib-kodiak | 1.0.52 | camxtest | `dda8af166e5c8c21e43d8fbe38ebf52c48cb2e68b2e40e6e62164946de888f9d` | dynamic-layers/openembedded-layer/recipes-multimedia/camx/camxlib-kodiak_1.0.52.bb |
| camxlib-kodiak | 1.0.52 | chicdk | `4f2bef99f01501e9165d740977200a34c0b039c2a6bc849e2fd8a027195d695d` | dynamic-layers/openembedded-layer/recipes-multimedia/camx/camxlib-kodiak_1.0.52.bb |
| camxlib-lemans | 1.0.56 | camx | `9ae18792b439aae460e6d4661718b665c23549abe549205a93efe9faa2b39fd4` | dynamic-layers/openembedded-layer/recipes-multimedia/camx/camxlib-lemans_1.0.56.bb |
| camxlib-lemans | 1.0.56 | camxcommon | `2eb4aa757a347923b1a53ef2875010ad408cf1ecfb54963ba2f8b67c03da581d` | dynamic-layers/openembedded-layer/recipes-multimedia/camx/camxlib-lemans_1.0.56.bb |
| camxlib-lemans | 1.0.56 | camxlib | `ade110131155ff1a4684e04fa4e426f35515240a54e2fe17d5403b8876dc358d` | dynamic-layers/openembedded-layer/recipes-multimedia/camx/camxlib-lemans_1.0.56.bb |
| camxlib-lemans | 1.0.56 | camxtest | `4aedd2d00fcc6292061ac4ecf4a242b546e90337bcda72654b601046aed9f104` | dynamic-layers/openembedded-layer/recipes-multimedia/camx/camxlib-lemans_1.0.56.bb |
| camxlib-lemans | 1.0.56 | chicdk | `b17187b39afe8fdaf90c4cd021a51052bf755c8c569997929c3ebf4f0da62412` | dynamic-layers/openembedded-layer/recipes-multimedia/camx/camxlib-lemans_1.0.56.bb |
| camxlib-nord | 1.0.56 | camx | `d9365e3d93d9e4439d44e37b2d2121b8960a48d71207758599c4c4c43377c78f` | dynamic-layers/openembedded-layer/recipes-multimedia/camx/camxlib-nord_1.0.56.bb |
| camxlib-nord | 1.0.56 | camxcommon | `0ebee7374c9d2275aa6346b3eac2794d8619968d95471ba85ae72b40530a49d7` | dynamic-layers/openembedded-layer/recipes-multimedia/camx/camxlib-nord_1.0.56.bb |
| camxlib-nord | 1.0.56 | camxlib | `25d8fb0ce63cf934cba7f2944196eab96e00cf92ad8ac33701de6f29662d1efb` | dynamic-layers/openembedded-layer/recipes-multimedia/camx/camxlib-nord_1.0.56.bb |
| camxlib-nord | 1.0.56 | camxtest | `757f612ee964d702aba774537b8af037a2f51c9c29a8bc03ae1e99071f3feab6` | dynamic-layers/openembedded-layer/recipes-multimedia/camx/camxlib-nord_1.0.56.bb |
| camxlib-nord | 1.0.56 | chicdk | `99a37dc09ccec8fefae3702d5deb0258c3af8f9a00e1e5655721ba60d59b32c4` | dynamic-layers/openembedded-layer/recipes-multimedia/camx/camxlib-nord_1.0.56.bb |
| camxlib-shikra | 1.0.59 | camx | `6c9bd69140feaac0bbe53c9286ad92672aa184771ab17a76cd0a569a8e634e74` | dynamic-layers/openembedded-layer/recipes-multimedia/camx/camxlib-shikra_1.0.59.bb |
| camxlib-shikra | 1.0.59 | camxcommon | `fe681e0025aa454f3413b2fd90d2d87d5d95e7d3ceb0e9d17db9a387f5435f42` | dynamic-layers/openembedded-layer/recipes-multimedia/camx/camxlib-shikra_1.0.59.bb |
| camxlib-shikra | 1.0.59 | camxlib | `7ad5498c802d13d2720c412302f2212a6652a1d31d697d52a1da12651dd8a174` | dynamic-layers/openembedded-layer/recipes-multimedia/camx/camxlib-shikra_1.0.59.bb |
| camxlib-shikra | 1.0.59 | camxtest | `5c73163a99c4d7a519fed65b80976628477914c763b09224bfac9a359e45afa7` | dynamic-layers/openembedded-layer/recipes-multimedia/camx/camxlib-shikra_1.0.59.bb |
| camxlib-shikra | 1.0.59 | chicdk | `34f3b70961a3283d245b5e5a757e1183b066ec16aa9f9444326eb7759fa20e00` | dynamic-layers/openembedded-layer/recipes-multimedia/camx/camxlib-shikra_1.0.59.bb |
| camxlib-talos | 1.0.56 | camx | `994af723115a6ee9d0da546fc51cdc95caa4a3ef5951056eaa0ba40413e3d768` | dynamic-layers/openembedded-layer/recipes-multimedia/camx/camxlib-talos_1.0.56.bb |
| camxlib-talos | 1.0.56 | camxcommon | `013fa88456820592e4916ccdd9273fd5fadae1173ba514040c0ba12c2e9fe064` | dynamic-layers/openembedded-layer/recipes-multimedia/camx/camxlib-talos_1.0.56.bb |
| camxlib-talos | 1.0.56 | camxlib | `092c5ec88495c61c4afbe585f1e60b0d06e965471a5112ff403fa0d7b9088174` | dynamic-layers/openembedded-layer/recipes-multimedia/camx/camxlib-talos_1.0.56.bb |
| camxlib-talos | 1.0.56 | camxtest | `704554b0cee426bca79e5e5c709c65bd201859139d441e1460c5e096d67a7663` | dynamic-layers/openembedded-layer/recipes-multimedia/camx/camxlib-talos_1.0.56.bb |
| camxlib-talos | 1.0.56 | chicdk | `19d9986f0319340721676d871034e89814c989953f9ba16c1c4e8dfa4dcc89e4` | dynamic-layers/openembedded-layer/recipes-multimedia/camx/camxlib-talos_1.0.56.bb |
| diag-router | 1.0.3 | - | `88277ae47fb6febd04e2531b1e46027a3416ce540ba78c9e92d0abdbadbc9c94` | recipes-test/diag-router/diag-router_1.0.3.bb |
| firmware-qcom-boot-eliza | 00014 | bootbinaries | `0bfe4c7eb19b0ea0cf1651332f6a0ad75bb0e787f112999c85cbf86cc0c0d885` | recipes-bsp/firmware-boot/firmware-qcom-boot-eliza_00014.bb |
| firmware-qcom-cdt-eliza |  | cq7790-evk | `c2d1fb4b5a913ad5adc691b3c94b34c6d09cd35aafbf58fe48e0ce94e884d5f4` | recipes-bsp/firmware-boot/firmware-qcom-cdt-eliza.bb |
| qairt-sdk | 2.50.0.260828 | - | `a346ea0e2c8631b46d57261a4969994cd9cc34124a8355bbc7b08b2c8bd859a5` | recipes-ml/qairt/qairt-sdk_2.50.0.260828.bb |
| qcom-adreno | 1.887.6 | - | `380988d9ab7bc74b79f037a584447a709972303d196b3fc3ed19ab7beecd5ae3` | recipes-graphics/adreno/qcom-adreno_1.887.6.bb |
| qcom-fastcv-binaries | 1.8.11 | - | `acc32906a30aa90d918f331ca60a9a958b2cd7242124526f3307f4486f9a8b1f` | recipes-multimedia/fastcv/qcom-fastcv-binaries_1.8.11.bb |
| qcom-sensors-binaries | 1.2.1 | - | `507652592b326bfeb1b31c4c37f61a5173439bd3dffa7ded72b675f834ea11bb` | dynamic-layers/openembedded-layer/recipes-support/sensors/qcom-sensors-binaries_1.2.1.bb |
