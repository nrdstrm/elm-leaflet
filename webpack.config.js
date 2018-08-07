var path = require("path");
var webpack = require("webpack");
var HtmlWebpackPlugin = require("html-webpack-plugin");
var autoprefixer = require("autoprefixer");

module.exports = {
    entry: {
        app: [
            "./src/static/index.js",
        ]
    },

    output: {
        path: path.resolve(__dirname + "/dist"),
        filename: "[name].js",
    },

    resolve: {
        extensions: [".js", ".elm"],
        modules: ["node_modules"],
        alias: {
            "./images/layers.png$": path.resolve(
                __dirname,
                "./node_modules/leaflet/dist/images/layers.png",
            ),
            "./images/layers-2x.png$": path.resolve(
                __dirname,
                "./node_modules/leaflet/dist/images/layers-2x.png",
            ),
            "./images/marker-icon.png$": path.resolve(
                __dirname,
                "./node_modules/leaflet/dist/images/marker-icon.png",
            ),
            "./images/marker-icon-2x.png$": path.resolve(
                __dirname,
                "./node_modules/leaflet/dist/images/marker-icon-2x.png",
            ),
            "./images/marker-shadow.png$": path.resolve(
                __dirname,
                "./node_modules/leaflet/dist/images/marker-shadow.png",
            ),
        },
    },

    module: {
        rules: [{
            test: /\.elm$/,
            exclude: [/elm-stuff/, /node_modules/],
            use: [{
                loader: "elm-webpack-loader",
                options: {
                    verbose: true,
                    warn: true,
                    debug: true,
                },
            }],
        }, {
            test: /\.(gif|svg|jpg|png)$/,
            loader: "file-loader"
        }, {
            test: /\leaflet.css$/,
            use: [{
                loader: "style-loader",
            }, {
                loader: "css-loader",
            }],
        }, {
            test: /\.css$/,
            exclude: /\leaflet.css$/,
            use: [{
                loader: "style-loader",
            }, {
                loader: "css-loader",
                options: {
                    modules: true,
                },
            }],
        }],

        noParse: /\.elm$/
    },

    plugins: [
        new webpack.LoaderOptionsPlugin({
            options: {
                postcss: [autoprefixer()]
            }
        }),
        new HtmlWebpackPlugin({
            template: "src/static/index.html",
            inject: "body",
            filename: "index.html",
        }),
    ],

    devServer: {
        inline: true,
        historyApiFallback: true,
        contentBase: "./src",
        hot: true,
        stats: {
            colors: true,
        },
    },
};
