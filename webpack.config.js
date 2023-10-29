module.exports = {
    //エントリーポイント
    entry: './src/index.js',

    //ファイルの出力
    output: {
        //出力先のパス（__dirnameはwebpack-tutorialフォルダの階層）
        path: `${__dirname}/dist`,
        //出力ファイル名
        filename: 'bundle.js'
    },

    //モード 出力ファイルが見やすい（≠minify）　,　　デフォルトは'production'
    mode: 'production',
}
