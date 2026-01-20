<template>
  <!-- 社交链接 -->
  <div class="social">
    <div class="link">
      <a
        v-for="item in socialLinks"
        :key="item.name"
        :href="item.url"
        target="_blank"
        @mouseenter="socialTip = item.tip"
        @mouseleave="socialTip = ''"
      >
        <img class="icon" :src="item.icon" height="24" />
      </a>
    </div>
    <span class="tip">{{ socialTip }}</span>
    <!-- 隐形链接触发区 -->
    <div class="hidden-trigger" @click="toggleHidden"></div>
  </div>
</template>

<script setup>
import socialLinksData from "@/assets/socialLinks.json";
import { computed, ref } from "vue";
import { SERVER_IP } from "@/config";

// 隐藏链接显示状态
const showHidden = ref(false);

// 社交链接数据（动态替换 IP，根据状态过滤隐藏项）
const socialLinks = computed(() => {
  return socialLinksData
    .filter((item) => showHidden.value || !item.hide)
    .map((item) => ({
      ...item,
      url: item.url.replace("SERVER_IP_PLACEHOLDER", SERVER_IP),
    }));
});

// 切换隐藏显示
const toggleHidden = () => {
  showHidden.value = !showHidden.value;
};

// 社交链接提示
const socialTip = ref("");
</script>

<style lang="scss" scoped>
.social {
  position: relative; /* 确保子元素绝对定位相对于此容器 */
  margin-top: 1rem;
  display: flex;
  align-items: center;
  justify-content: space-between;
  max-width: 460px;
  width: 100%;
  height: 42px;
  background-color: transparent;
  border-radius: 6px;
  backdrop-filter: blur(0);
  animation: fade 0.5s;
  transition:
    background-color 0.3s,
    backdrop-filter 0.3s;
  @media (max-width: 840px) {
    max-width: 100%;
    justify-content: center;
    .link {
      justify-content: space-evenly !important;
      width: 90%;
    }
    .tip {
      display: none !important;
    }
  }

  .link {
    display: flex;
    align-items: center;
    justify-content: center;
    a {
      display: inherit;
      .icon {
        margin: 0 12px;
        transition: transform 0.3s;
        &:hover {
          transform: scale(1.1);
        }
        &:active {
          transform: scale(1);
        }
      }
    }
  }
  .tip {
    display: none;
    margin-right: 12px;
    animation: fade 0.5s;
  }
  @media (min-width: 768px) {
    &:hover {
      background-color: #00000040;
      backdrop-filter: blur(5px);
      .tip {
        display: block;
      }
    }
  }
  .hidden-trigger {
    position: absolute;
    right: 0;
    top: 0;
    width: 20px;
    height: 100%;
    cursor: default; /* 不显示手型光标，伪装成空白区域 */
    z-index: 10;
  }
}
</style>
