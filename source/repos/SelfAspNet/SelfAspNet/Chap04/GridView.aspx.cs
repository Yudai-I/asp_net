using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SelfAspNet.Chap04
{
    public partial class GridView : System.Web.UI.Page
    {
        protected void GridView2_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            //誤った入力が行われた場合の処理
            if (!Page.IsValid)
            {
                e.Cancel = true;
            }
            //正しい入力が行われた場合の処理
            else
            {
                //更新前の任意処理
            }

        }

        protected void GridView2_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            //Exceptionプロパティが未定義でない(エラーが起こった)場合の処理
            if (e.Exception != null)
            {
                //ExceptionHandledプロパティをtrueにすることで、Asp.net側ではなく開発者側のエラーページが表示可能
                e.ExceptionHandled = true;
                //Asp.net側が判断したエラー内容を出力する
                Response.Write(e.Exception.Message);
            }

        }

        protected void GridView2_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                var ltr = new Literal();
                ltr.Text = $"総ページ : {GridView2.PageCount}";
                e.Row.Cells[e.Row.Cells.Count - 1].Wrap = false;
                e.Row.Cells[e.Row.Cells.Count - 1].Controls.Add(ltr);
            }
        }
    }
}