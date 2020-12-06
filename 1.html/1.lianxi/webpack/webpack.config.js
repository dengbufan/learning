
const path=require('path'); //node获取文件路径
module.exports={
  entry:'./src/js/main.js', //入口 
  output:{  //出口，一般是对象类型
    path:path.resolve(__dirname,'dist'), //这里要动态的获取绝对路径，因为路径可能会发生改变
    filename:'ccc.js',
  }, 
  module: {
    rules: [
      {
        test: /\.css$/, //正则表达式匹配CSS文件
        use: ['style-loader','css-loader'],//css-loader只负责加载CSS，不负责解析,有多个loader时，webpack默认是从右向左解析的
      },
    ],
  },
}