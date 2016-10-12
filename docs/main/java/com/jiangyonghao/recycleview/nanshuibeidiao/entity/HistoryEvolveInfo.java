package com.jiangyonghao.recycleview.nanshuibeidiao.entity;

import java.util.List;

/**
 * Created by user on 2016/9/6.
 */
public class HistoryEvolveInfo {

    /**
     * data : [{"id":"0bc0d35c-9143-4182-839e-046b15db215c","disposeDescription":"事件进展反馈内容图片事件进展反馈内容图片事件进展反馈内容图片事件进展反馈内容图片事件进展反馈内容图片事件进展反馈内容图片事件进展反馈内容图片事件进展反馈内容图片事件进展反馈内容图片事件进展反馈内容图片事件进展反馈内容图片事件进展反馈内容图片事件进展反馈内容图片事件进展反馈内容图片事件进展反馈内容图片事件进展反馈内容图片","fileList":[{"id":"5daf02b8-99ea-441d-aa3a-577b5bc19df6","name":"Koala.jpg","label":"photo","url":"gcyw/incidentProgress/2016/9/5caf786c-c942-4317-90b2-f34d0e434330.jpg","file_type":"image"},{"id":"09c11831-4de8-444d-9287-1841f65d0d70","name":"Lighthouse.jpg","label":"photo","url":"gcyw/incidentProgress/2016/9/63a4c518-93b2-4c48-90c2-650be7dae93c.jpg","file_type":"image"}],"disposeBy":"管理人员","addTime":"2016-09-19 16:01:14"},{"id":"cc8d5018-2fc9-4939-92ac-0b1c42fe47cc","disposeDescription":"按参考预案","fileList":[{"id":"8cb96603-8640-4c75-8fe8-5c4938906346","name":"sample.mp4","label":"video","url":"gcyw/incidentProgress/2016/9/e02b7a3a-5c75-49a2-98e8-e99c557bcc98.mp4","file_type":"video"}],"disposeBy":"机关工会","addTime":"2016-09-19 16:12:39"},{"id":"2cc4f1c5-cee6-4626-90dd-f7fed0d5b519","disposeDescription":"事件进展填报内容","disposeBy":"管理处","addTime":"2016-09-22 18:35:28"}]
     * msg : 获取数据成功!
     * status : 100
     */

    private String msg;
    private String status;
    /**
     * id : 0bc0d35c-9143-4182-839e-046b15db215c
     * disposeDescription : 事件进展反馈内容图片事件进展反馈内容图片事件进展反馈内容图片事件进展反馈内容图片事件进展反馈内容图片事件进展反馈内容图片事件进展反馈内容图片事件进展反馈内容图片事件进展反馈内容图片事件进展反馈内容图片事件进展反馈内容图片事件进展反馈内容图片事件进展反馈内容图片事件进展反馈内容图片事件进展反馈内容图片事件进展反馈内容图片
     * fileList : [{"id":"5daf02b8-99ea-441d-aa3a-577b5bc19df6","name":"Koala.jpg","label":"photo","url":"gcyw/incidentProgress/2016/9/5caf786c-c942-4317-90b2-f34d0e434330.jpg","file_type":"image"},{"id":"09c11831-4de8-444d-9287-1841f65d0d70","name":"Lighthouse.jpg","label":"photo","url":"gcyw/incidentProgress/2016/9/63a4c518-93b2-4c48-90c2-650be7dae93c.jpg","file_type":"image"}]
     * disposeBy : 管理人员
     * addTime : 2016-09-19 16:01:14
     */

    private List<DataBean> data;

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public List<DataBean> getData() {
        return data;
    }

    public void setData(List<DataBean> data) {
        this.data = data;
    }

    public static class DataBean {
        private String id;
        private String disposeDescription;
        private String disposeBy;
        private String addTime;
        private String creatorName;

        public String getCreatorName() {
            return creatorName;
        }

        public void setCreatorName(String creatorName) {
            this.creatorName = creatorName;
        }

        /**
         * id : 5daf02b8-99ea-441d-aa3a-577b5bc19df6
         * name : Koala.jpg
         * label : photo
         * url : gcyw/incidentProgress/2016/9/5caf786c-c942-4317-90b2-f34d0e434330.jpg
         * file_type : image
         */

        private List<FileListBean> fileList;

        public String getId() {
            return id;
        }

        public void setId(String id) {
            this.id = id;
        }

        public String getDisposeDescription() {
            return disposeDescription;
        }

        public void setDisposeDescription(String disposeDescription) {
            this.disposeDescription = disposeDescription;
        }

        public String getDisposeBy() {
            return disposeBy;
        }

        public void setDisposeBy(String disposeBy) {
            this.disposeBy = disposeBy;
        }

        public String getAddTime() {
            return addTime;
        }

        public void setAddTime(String addTime) {
            this.addTime = addTime;
        }

        public List<FileListBean> getFileList() {
            return fileList;
        }

        public void setFileList(List<FileListBean> fileList) {
            this.fileList = fileList;
        }

        public static class FileListBean {
            private String id;
            private String name;
            private String label;
            private String url;
            private String file_type;

            public String getId() {
                return id;
            }

            public void setId(String id) {
                this.id = id;
            }

            public String getName() {
                return name;
            }

            public void setName(String name) {
                this.name = name;
            }

            public String getLabel() {
                return label;
            }

            public void setLabel(String label) {
                this.label = label;
            }

            public String getUrl() {
                return url;
            }

            public void setUrl(String url) {
                this.url = url;
            }

            public String getFile_type() {
                return file_type;
            }

            public void setFile_type(String file_type) {
                this.file_type = file_type;
            }
        }
    }
}
