@react.component
let make = (~className: option<string>=?) => {
  <svg
    viewBox="0 0 1249 227"
    fill="none"
    xmlns="http://www.w3.org/2000/svg"
    role="image"
    className={Belt.Option.getWithDefault(className, ``)}>
    <title> {`seob.dev`->React.string} </title>
    <path
      d="M233.207 226.84C262.007 226.84 287.608 219.8 307.448 206.36L290.807 172.44C276.087 181.4 262.647 187.8 245.368 187.8C229.048 187.8 214.007 181.72 212.407 157.72H315.127C317.047 151.96 320.888 136.6 320.888 122.52C320.888 84.76 296.567 59.16 254.327 59.16C205.047 59.16 160.887 97.56 160.887 155.16C160.887 205.08 192.247 226.84 233.207 226.84ZM253.047 98.2C265.848 98.2 274.168 105.88 274.168 121.56C274.168 122.84 274.168 124.44 273.847 125.72H217.207C225.207 106.52 241.207 98.2 253.047 98.2ZM399.483 226.84C447.483 226.84 492.923 189.08 492.923 130.84C492.923 87.32 465.403 59.16 420.603 59.16C372.603 59.16 327.163 96.92 327.163 155.16C327.163 198.68 354.683 226.84 399.483 226.84ZM403.323 185.24C388.603 185.24 379.003 174.36 379.003 153.88C379.003 121.88 397.562 100.76 416.763 100.76C431.483 100.76 441.083 111.64 441.083 132.12C441.083 164.12 422.523 185.24 403.323 185.24ZM581.118 226.84C625.278 226.84 666.238 180.12 666.238 121.24C666.238 81.56 647.678 59.16 614.398 59.16C599.038 59.16 580.798 66.84 567.038 80.92H566.398L575.998 47L585.598 0.279987H534.398L489.598 223H531.838L538.878 207H539.518C547.198 219.16 563.838 226.84 581.118 226.84ZM573.438 185.24C564.478 185.24 555.518 181.4 551.038 173.08L560.638 125.08C571.518 107.16 583.678 100.76 593.918 100.76C604.798 100.76 613.118 108.44 613.118 127.64C613.118 161.56 593.598 185.24 573.438 185.24Z"
      fill="#17181A"
    />
    <path
      d="M785.485 226.84C802.765 226.84 821.325 217.88 836.045 201.88H837.325V223H878.925L923.725 0.279987H872.525L863.565 47L860.365 77.08H859.725C852.045 66.2 839.885 59.16 819.405 59.16C775.245 59.16 734.285 105.88 734.285 164.76C734.285 204.44 754.125 226.84 785.485 226.84ZM805.325 185.24C794.445 185.24 787.405 176.92 787.405 158.36C787.405 124.44 807.245 100.76 829.005 100.76C835.725 100.76 845.645 104.6 850.125 112.92L839.885 162.84C829.005 178.84 815.565 185.24 805.325 185.24ZM979.92 226.84C1008.72 226.84 1034.32 219.8 1054.16 206.36L1037.52 172.44C1022.8 181.4 1009.36 187.8 992.08 187.8C975.76 187.8 960.72 181.72 959.12 157.72H1061.84C1063.76 151.96 1067.6 136.6 1067.6 122.52C1067.6 84.76 1043.28 59.16 1001.04 59.16C951.76 59.16 907.6 97.56 907.6 155.16C907.6 205.08 938.96 226.84 979.92 226.84ZM999.76 98.2C1012.56 98.2 1020.88 105.88 1020.88 121.56C1020.88 122.84 1020.88 124.44 1020.56 125.72H963.92C971.92 106.52 987.92 98.2 999.76 98.2Z"
      fill="#17181A"
    />
    <path
      d="M694.047 225.88C712.767 225.88 725.247 211.96 725.247 194.68C725.247 177.64 712.767 163.48 694.047 163.48C675.327 163.48 662.847 177.64 662.847 194.68C662.847 211.96 675.327 225.88 694.047 225.88Z"
      fill="#1A9AE1"
    />
    <path
      d="M74.5425 226.84C116.783 226.84 149.423 209.88 149.423 173.08C149.423 146.84 130.863 134.04 102.703 124.44C78.3825 116.12 71.3425 112.92 71.3425 106.52C71.3425 99.8 78.0625 96.92 87.9825 96.92C103.983 96.92 120.943 104.92 133.743 115.16L161.583 85.4C146.223 70.36 125.103 59.16 93.7425 59.16C56.6225 59.16 23.3425 77.72 23.3425 112.92C23.3425 137.88 41.9025 152.6 73.9025 162.84C96.3025 169.88 101.423 173.08 101.423 180.12C101.423 185.88 95.0225 189.08 82.8625 189.08C64.3025 189.08 45.1025 182.04 28.1425 165.4L0.3025 197.4C18.2225 215.32 43.8225 226.84 74.5425 226.84Z"
      fill="#17181A"
    />
    <path
      d="M1100.42 223H1159.94L1248.26 63H1197.7L1161.22 136.6C1153.22 152.6 1144.9 169.56 1137.86 185.88H1136.58C1135.3 168.92 1134.34 152.6 1132.42 136.6L1124.1 63H1073.54L1100.42 223Z"
      fill="#17181A"
    />
  </svg>
}

let default = make
