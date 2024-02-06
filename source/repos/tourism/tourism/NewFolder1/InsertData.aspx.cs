using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

using OpenAI_API;
using System.Text;
using System.Threading.Tasks;


namespace tourism.NewFolder1
{
    public partial class InsertData : System.Web.UI.Page
    {

        private string prompt;
        protected async void Page_Load(object sender, EventArgs e)
        {
            string language = Page.Request.UserLanguages[0].ToString();
            if (language != "ja")
            {
                Button1.Text = "View Reviews";
                Button2.Text = "Register Review";
                Button5.Text = "View Feedback";
                Label1.Text = "Review";
                Button4.Text = "Analyze";
            }
            
            if (Session["mermaid"] != null)
            {
                string script = $@"
        // ダイアグラムを表示するdiv要素を取得
        var divElement = document.querySelector('.mermaid');

        // ダイアグラムのテキストをセット
        divElement.textContent = `{Session["mermaid"].ToString()}`;

    ";

                // 生成したJavaScriptコードをブラウザに送信
                ScriptManager.RegisterStartupScript(this, this.GetType(), "renderMermaid", script, true);
            }
        }


        // 整形
        static string FormatGraphLR(string input)
        {
            // 例#を除去
            input = input.Replace("例#", "");
            input = input.Replace("mermaid", "");
            input = input.Replace("```", "");
            input = input.Replace("図のコード:", "");
            input = input.Replace("以下のような図のコードを生成することができます。", "");
            Console.WriteLine($"Input before formatting: {input}");

            return input;
        }

        static string FormatFeedback(string input)
        {
            // 例#を除去
            input = input.Replace("\"", "");
            input = input.Replace("{", "");
            input = input.Replace("}", "");

            return input;
        }

        // 回答の生成
        private async Task<string> ChatGptAsync(string prompt)
        {
            try
            {
                var api = new OpenAI_API.OpenAIAPI("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");
                var chat = api.Chat.CreateConversation();

                // ChatGPTに質問
                chat.AppendUserInput(prompt);

                // ChatGPTの回答
                string response = await chat.GetResponseFromChatbotAsync();
                //txtresult.Text = ExtractMermaidDiagram(response);
                //return ExtractMermaidDiagram(response); // Task<string> を返す
                return FormatGraphLR(response);
            }
            catch (Exception ex)
            {
                
                System.Diagnostics.Debug.WriteLine($"エラー: {ex.ToString()}");
                //txtresult.Text = $"エラー: {ex.Message}";

                return string.Empty; 
            }
        }


        // プロンプト作成
        protected async void Button1_Click(object sender, EventArgs e)
        {
            GridViewRow row = (GridViewRow)((Button)sender).NamingContainer;

            // GridView内の特定のセルのデータを取得
            string reviewData = row.Cells[2].Text;

            // 取得したデータを利用するなり表示するなり
            string txt1 = @"{あなたが分析する口コミ}の口コミについて、graph LRから始まるmermaid図を描けるコードを、私が示す5つの{ルール}に全て従って回答を生成してください。また、mermaid図のコードを生成直後に良い点と悪い点を、C#の連想配列{}にして教えて
###
{ルール1}###
marmaid図を生成するコードと配列コード以外のあなたの説明や言葉は不要。
###
{ルール2}###
作成するmermaid図には、{良い点}と{悪い点}を第１項目として分けて、さらに、それら悪い点に対する{解決策}もmermaid図に。
###
{ルール3}###
subgraphは使わないで。
###
{ルール4}###
図形は四角形にして。
###
{ルール5}###
出力形式例は以下。
例###
graph LR 
A[良い点] --> B(朝食の型と朝食スタッフの対応)
A --> C(部屋の清潔感)

F[悪い点] --> G(チェックイン時のスタッフの対応)
F --> H(提携している温浴施設まで意外と遠い)

G --> K(スタッフトレーニングの強化)
H --> L(アクセス情報の提供改善)

GOOD
string[] positivePoints = 

BAD
string[] negativePoints = 

IMP
string[] improvePoints = 
###
上記の出力例の形式に則り、以下の口コミを分析して
###";
            prompt = $"{txt1}あなたが分析する口コミ###{reviewData}###";

            string response = await ChatGptAsync(prompt);
        
            // マーメイド図の生成
            //string mermaidDiagram = ExtractMermaidDiagram(response);
            string mermaidDiagram = FormatGraphLR(response);
            Prompttxt.Text = FormatGraphLR(response);
            string[] lines = mermaidDiagram.Split('\n');
            int good = Array.FindIndex(lines, line => line.Contains("GOOD"));
            int bad = Array.FindIndex(lines, line => line.Contains("BAD"));
            int imp = Array.FindIndex(lines, line => line.Contains("IMP"));
            string mermaidCodeExtracted = string.Join(Environment.NewLine, lines.Take(good));
            string ryouLine = lines[good + 1];
            Regex regex = new Regex(@"\[([^[\]]+)\]|\{([^{}]*)\}");
            Match match1 = regex.Match(ryouLine);
            string[] ryou = match1.Success ? match1.Groups[1].Success ? match1.Groups[1].Value.Split(',').Select(value => value.Trim()).ToArray() : match1.Groups[2].Success ? match1.Groups[2].Value.Split(',').Select(value => value.Trim()).ToArray() : Array.Empty<string>() : Array.Empty<string>();
            string akuLine = lines[bad + 1];
            Match match2 = regex.Match(akuLine);
            string[] aku = match2.Success ? match2.Groups[1].Success ? match2.Groups[1].Value.Split(',').Select(value => value.Trim()).ToArray() : match2.Groups[2].Success ? match2.Groups[2].Value.Split(',').Select(value => value.Trim()).ToArray() : Array.Empty<string>() : Array.Empty<string>();
            string kaizenLine = lines[imp + 1];
            Match match3 = regex.Match(kaizenLine);
            string[] kaizen = match3.Success ? match3.Groups[1].Success ? match3.Groups[1].Value.Split(',').Select(value => value.Trim()).ToArray() : match3.Groups[2].Success ? match3.Groups[2].Value.Split(',').Select(value => value.Trim()).ToArray() : Array.Empty<string>() : Array.Empty<string>();
            string goods = ryou.Any() ? string.Join(", ", ryou) : string.Empty;
            string bads = aku.Any() ? string.Join(", ", aku) : string.Empty;
            string imps = kaizen.Any() ? string.Join(", ", kaizen) : string.Empty;
            TextBox4.Text = mermaidCodeExtracted;
            string Good = $"{{\"{goods}\"}}";
            string Bad = $"{{\"{bads}\"}}";
            string Improve = $"{{\"{imps}\"}}";
            string GOOD = Good.Replace("\"\"", "\"");
            string BAD = Bad.Replace("\"\"", "\"");
            string IMPROVE = Improve.Replace("\"\"", "\"");
            this.Good.Text = GOOD;
            this.Bad.Text = BAD;
            Imp.Text = IMPROVE;

            // JavaScriptコードを生成
            string script = $@"
        // ダイアグラムを表示するdiv要素を取得
        var divElement = document.querySelector('.mermaid');

        // ダイアグラムのテキストをセット
        divElement.textContent = `{mermaidCodeExtracted}`;
var loadingImage = document.getElementById('loadingImage');
    loadingImage.style.display = 'none';

    ";

            // 生成したJavaScriptコードをブラウザに送信
            ScriptManager.RegisterStartupScript(this, this.GetType(), "renderMermaid", script, true);
            Image2.ImageUrl = "/img/cat.jpeg";
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            string[] GOOD = Good.Text.Split(',').Select(item => item.Trim()).ToArray();
            string[] BAD = Bad.Text.Split(',').Select(item => item.Trim()).ToArray();
            string[] IMPROVE = Imp.Text.Split(',').Select(item => item.Trim()).ToArray();
            int maxCount = Math.Max(Math.Max(GOOD.Length, BAD.Length), IMPROVE.Length);
            var setting = ConfigurationManager.ConnectionStrings["Reviews"];
            using (var db = new SqlConnection(setting.ConnectionString))
            {
                for (int i = 0; i < maxCount; i++)
                {
                    var comm = new SqlCommand("INSERT INTO Feedback(good, bad, [plan]) VALUES(@good, @bad, @plan)", db);

                    if (i < GOOD.Length)
                        comm.Parameters.AddWithValue("@good", FormatFeedback(GOOD[i]));
                    else
                        comm.Parameters.AddWithValue("@good", DBNull.Value);

                    if (i < BAD.Length)
                        comm.Parameters.AddWithValue("@bad", FormatFeedback(BAD[i]));
                    else
                        comm.Parameters.AddWithValue("@bad", DBNull.Value);

                    if (i < IMPROVE.Length)
                        comm.Parameters.AddWithValue("@plan", FormatFeedback(IMPROVE[i]));
                    else
                        comm.Parameters.AddWithValue("@plan", DBNull.Value);

                    db.Open();
                    comm.ExecuteNonQuery();
                    db.Close();
                }
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            
            Response.Redirect("RegistrateData.aspx");
        }

        protected void Button5_Click(object sender, EventArgs e)
        {
            Session["mermaid"] = TextBox4.Text.Trim();
            Response.Redirect("ViewFeedback.aspx");
        }

        protected void Button6_Click(object sender, EventArgs e)
        {
            string search = TextBox5.Text.Trim();

            var setting = ConfigurationManager.ConnectionStrings["Reviews"];
            using (var db = new SqlConnection(setting.ConnectionString))
            {
                var commandText = "SELECT [Id], [review] FROM [Review] WHERE [review] LIKE '%' + @search + '%'";
                var comm = new SqlCommand(commandText, db);
                comm.Parameters.AddWithValue("@search", search);

                var adapter = new SqlDataAdapter(comm);
                var dataTable = new System.Data.DataTable();

                // Step 3: Bind the result to GridView1
                db.Open();
                adapter.Fill(dataTable);
                db.Close();

                GridView1.DataSource = dataTable;
                GridView1.DataBind();
            }
        }
    }

}