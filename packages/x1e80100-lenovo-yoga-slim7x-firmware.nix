{
  fetchFromGitHub,
  fetchurl,
  runCommand,
}:

let
  # I verified manually that the following files match the SHA256 hashes of ones from my Windows install:
  # 5556fa684f96b203c330ba0bc2daddedeb5c358ff423b3d190e74ddfcde8b9ad  qcom/x1e80100/LENOVO/83ED/adsp_dtbs.elf
  # 351e3733bfd894dfe78322cfad2ad54a7401ae1ea62e1e4ed0086491f03a47db  qcom/x1e80100/LENOVO/83ED/cdsp_dtbs.elf
  # 0497f837f1d3b1788cbdb1fad665eea1e42fd5ad3a41fabffd421e5df7b9a1fc  qcom/x1e80100/LENOVO/83ED/qcadsp8380.mbn
  # 98ed054924440559b56388235faa279ae9f419cae467ad137f1f4fb53f9f253c  qcom/x1e80100/LENOVO/83ED/qccdsp8380.mbn
  # 31a3143b19b809b1eac200630ad9b50d0893a4820ba9e2cc5a03c0796f592da9  qcom/x1e80100/LENOVO/83ED/qcdxkmsuc8380.mbn
  firmware = fetchFromGitHub {
    owner = "Seraphin-";
    repo = "linux-firmware-x1e80100-lenovo-yoga-slim7x";
    rev = "2719d51f904b7312f61115c0461e59b4bbe9909d";
    hash = "sha256-dhfplH0MdKupdgaxM0GOecNzw9Vp0PE+8b/KaQUP+/I=";
  };

  # 460549a801a1532d57848422a2c9833d9b638ecab5263367908ac3cde9ed647a  qca/hmtbtfw20.tlv
  # 8b889d62ba0f22d6612ed0f6534aa1399533b851c7cc171661bdba9071855e72  qca/hmtnv20.b112
  hmtbtfw20 = fetchurl {
    url = "https://github.com/hogliux/yoga7x-firmware/raw/f2ce80c668f91938c67e8e5196a777fcc905d9d3/firmware/qca/hmtbtfw20.tlv";
    hash = "sha256-RgVJqAGhUy1XhIQiosmDPZtjjsq1JjNnkIrDzentZHo=";
  };
  hmtnv20 = fetchurl {
    url = "https://github.com/hogliux/yoga7x-firmware/raw/f2ce80c668f91938c67e8e5196a777fcc905d9d3/firmware/qca/hmtnv20.b112";
    hash = "sha256-i4idYroPItZhLtD2U0qhOZUzuFHHzBcWYb26kHGFXnI=";
  };
in
runCommand "x1e80100-lenovo-yoga-slim7x-firmware" { } ''
  mkdir -p $out/lib/firmware/qcom/x1e80100/LENOVO/83ED
  cp ${firmware}/qcom/x1e80100/LENOVO/83ED/{adsp_dtbs.elf,cdsp_dtbs.elf,qcadsp8380.mbn,qccdsp8380.mbn,qcdxkmsuc8380.mbn} \
    $out/lib/firmware/qcom/x1e80100/LENOVO/83ED/

  mkdir -p $out/lib/firmware/qca
  cp ${hmtbtfw20} $out/lib/firmware/qca/hmtbtfw20.tlv
  cp ${hmtnv20} $out/lib/firmware/qca/hmtnv20.b112
''
